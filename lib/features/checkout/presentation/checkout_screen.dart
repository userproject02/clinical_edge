import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/payments/payment_gateway.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/checkout/domain/card_rules.dart';
import 'package:clinical_edge/features/checkout/domain/purchase_course.dart';
import 'package:clinical_edge/features/checkout/presentation/checkout_providers.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:clinical_edge/features/courses/presentation/course_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Selected payment method.
enum CheckoutMethod {
  /// Card form.
  card,

  /// Mock Apple Pay sheet.
  applePay,
}

/// `/learn/:courseId/checkout` (PAY-1).
class CheckoutScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const new({required this.courseId, super.key});

  /// Course id from the route.
  final String courseId;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

enum _Banner { none, declined, cancelled }

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _number = TextEditingController();
  final _expiry = TextEditingController();
  final _cvc = TextEditingController();
  CheckoutMethod _method = CheckoutMethod.card;
  Set<CardError> _errors = const {};
  bool _processing = false;
  _Banner _banner = _Banner.none;
  bool _logged = false;

  @override
  void dispose() {
    _number.dispose();
    _expiry.dispose();
    _cvc.dispose();
    super.dispose();
  }

  void _clearCard() {
    _number.clear();
    _expiry.clear();
    _cvc.clear();
  }

  Future<void> _pay(Course course) async {
    if (_processing) return; // double-tap guard
    final today = ref.read(clockProvider).today();
    PaymentMethod method;
    String? last4;
    if (_method == CheckoutMethod.card) {
      final errors = validateCard(
        number: _number.text,
        expiry: _expiry.text,
        cvc: _cvc.text,
        today: today,
      );
      setState(() => _errors = errors);
      if (errors.isNotEmpty) return;
      last4 = CardRules.last4(_number.text);
      method = CardMethod(mockPaymentToken('card'));
    } else {
      method = ApplePayMethod(mockPaymentToken('applepay'));
    }
    setState(() {
      _processing = true;
      _banner = _Banner.none;
    });
    final router = GoRouter.of(context);
    try {
      final outcome = await ref.read(purchaseCourseProvider)(
        course,
        method,
        cardLast4: last4,
      );
      if (!mounted) return;
      switch (outcome) {
        case Purchased(:final order):
          _clearCard();
          router.go(AppRoutes.receipt(course.id, order.id));
        case PurchaseDeclined():
          setState(() => _banner = _Banner.declined);
        case final PurchaseNeeds3ds pending:
          final approved = await _show3ds(course);
          if (!mounted) return;
          if (approved) {
            final order = await ref.read(complete3dsProvider)(
              course,
              pending,
              method,
              cardLast4: last4,
            );
            if (!mounted) return;
            _clearCard();
            router.go(AppRoutes.receipt(course.id, order.id));
          } else {
            setState(() => _banner = _Banner.cancelled);
          }
      }
    } finally {
      if (mounted) setState(() => _processing = false);
    }
  }

  Future<bool> _show3ds(Course course) async {
    final l = AppLocalizations.of(context);
    final total = PriceBreakdown(course.price).total.format(l);
    final ok = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog.fullscreen(
        key: const Key('checkout.3ds'),
        child: _ThreeDsPage(amount: total),
      ),
    );
    return ok ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = ref.watch(courseProgressProvider(widget.courseId)).value;
    if (p == null) {
      return AppScaffold.detail(
        title: l.titleCheckout,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 240),
        ),
      );
    }
    final course = p.course;
    if (!_logged) {
      _logged = true;
      ref.read(logCheckoutStartProvider)(course);
    }
    final price = PriceBreakdown(course.price);
    final total = price.total.format(l);
    final c = context.colors;
    return PopScope(
      canPop: !_processing,
      child: AppScaffold.detail(
        title: l.titleCheckout,
        onBack: _processing
            ? () {}
            : () => context.canPop()
                  ? context.pop()
                  : context.go(AppRoutes.course(course.id)),
        bottomBar: DecoratedBox(
          decoration: BoxDecoration(
            color: c.surface,
            border: Border(top: BorderSide(color: c.outline)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: PrimaryButton(
                key: const Key('checkout.pay'),
                label: _processing
                    ? l.checkoutProcessing
                    : _method == CheckoutMethod.card
                    ? l.checkoutPay(total)
                    : l.checkoutPayApple(total),
                icon: _processing
                    ? null
                    : _method == CheckoutMethod.card
                    ? Icons.lock_outline_rounded
                    : Icons.apple,
                loading: _processing,
                onPressed: _processing ? null : () => unawaited(_pay(course)),
              ),
            ),
          ),
        ),
        body: AbsorbPointer(
          absorbing: _processing,
          child: ListView(
            key: const Key('checkout.list'),
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
            children: <Widget>[
              if (_banner != _Banner.none) ...<Widget>[
                _ErrorBanner(
                  cancelled: _banner == _Banner.cancelled,
                  onRetry: () => unawaited(_pay(course)),
                ),
                const SizedBox(height: 12),
              ],
              _Summary(course: course, price: price),
              const SizedBox(height: 18),
              Text(l.checkoutMethod, style: context.sectionTitle),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _MethodCard(
                      key: const Key('checkout.method.card'),
                      label: l.checkoutCard,
                      icon: Icons.credit_card_rounded,
                      selected: _method == CheckoutMethod.card,
                      onTap: () =>
                          setState(() => _method = CheckoutMethod.card),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MethodCard(
                      key: const Key('checkout.method.apple'),
                      label: l.checkoutApplePay,
                      icon: Icons.apple,
                      selected: _method == CheckoutMethod.applePay,
                      onTap: () =>
                          setState(() => _method = CheckoutMethod.applePay),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (_method == CheckoutMethod.card)
                _CardForm(
                  number: _number,
                  expiry: _expiry,
                  cvc: _cvc,
                  errors: _errors,
                  onChanged: () {
                    if (_errors.isNotEmpty) setState(() => _errors = {});
                  },
                )
              else
                const _ApplePaySheet(),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.lock_outline_rounded, size: 16, color: c.muted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l.checkoutLockNote,
                      style: context.caption.copyWith(color: c.muted),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const new({required this.course, required this.price});

  final Course course;
  final PriceBreakdown price;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final cover = coverColor(context, course.cover);
    return Container(
      key: const Key('checkout.summary'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l.checkoutOrderSummary, style: context.cardTitle),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cover,
                  borderRadius: BorderRadius.circular(AppRadii.field),
                ),
                child: Icon(coverIcon(course.cover), color: c.onHero),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      course.title.of(context),
                      style: context.body.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      l.checkoutLessonsCredits(
                        course.lessons.length,
                        course.cpdCredits,
                      ),
                      style: context.caption.copyWith(color: c.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: c.outline),
          const SizedBox(height: 10),
          AmountRow(label: l.checkoutSubtotal, value: price.subtotal.format(l)),
          AmountRow(
            label: l.checkoutVat(Formats.percent(vatPercent)),
            value: price.vat.format(l),
          ),
          const SizedBox(height: 4),
          AmountRow(
            key: const Key('checkout.total'),
            label: l.checkoutTotal,
            value: price.total.format(l),
            strong: true,
          ),
        ],
      ),
    );
  }
}

/// Label/amount row (checkout summary and receipt).
class AmountRow extends StatelessWidget {
  /// Creates the row.
  const new({
    required this.label,
    required this.value,
    this.strong = false,
    super.key,
  });

  /// Left label.
  final String label;

  /// Right value (already LTR-isolated where numeric).
  final String value;

  /// Bold total style.
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = strong
        ? context.cardTitle.copyWith(letterSpacing: 0)
        : context.body.copyWith(color: c.muted);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Text(label, style: style)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: strong ? style : context.body,
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const new({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? c.brandSoft : c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: BorderSide(
            color: selected ? c.brand : c.outline,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: selected ? c.brand : c.text),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: context.body.copyWith(
                    fontWeight: FontWeight.w700,
                    color: selected ? c.brand : c.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardForm extends StatelessWidget {
  const new({
    required this.number,
    required this.expiry,
    required this.cvc,
    required this.errors,
    required this.onChanged,
  });

  final TextEditingController number;
  final TextEditingController expiry;
  final TextEditingController cvc;
  final Set<CardError> errors;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          key: const Key('checkout.number'),
          controller: number,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          autofillHints: const <String>[AutofillHints.creditCardNumber],
          style: context.mono.copyWith(fontSize: 16),
          inputFormatters: <TextInputFormatter>[_CardNumberFormatter()],
          onChanged: (_) => onChanged(),
          decoration: InputDecoration(
            labelText: l.checkoutCardNumber,
            hintText: l.checkoutCardHint,
            hintTextDirection: TextDirection.ltr,
            errorText: errors.contains(CardError.number)
                ? l.checkoutErrorNumber
                : null,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextField(
                key: const Key('checkout.expiry'),
                controller: expiry,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
                style: context.mono.copyWith(fontSize: 16),
                inputFormatters: <TextInputFormatter>[_ExpiryFormatter()],
                onChanged: (_) => onChanged(),
                decoration: InputDecoration(
                  labelText: l.checkoutExpiry,
                  hintText: l.checkoutExpiryHint,
                  hintTextDirection: TextDirection.ltr,
                  errorMaxLines: 2,
                  errorText: errors.contains(CardError.expiry)
                      ? l.checkoutErrorExpiry
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                key: const Key('checkout.cvc'),
                controller: cvc,
                keyboardType: TextInputType.number,
                textDirection: TextDirection.ltr,
                obscureText: true,
                style: context.mono.copyWith(fontSize: 16),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: (_) => onChanged(),
                decoration: InputDecoration(
                  labelText: l.checkoutCvc,
                  errorText: errors.contains(CardError.cvc)
                      ? l.checkoutErrorCvc
                      : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = CardRules.digits(newValue.text);
    final text = CardRules.group(
      digits.length > 19 ? digits.substring(0, 19) : digits,
    );
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var d = CardRules.digits(newValue.text);
    if (d.length > 4) d = d.substring(0, 4);
    final text = d.length <= 2 ? d : '${d.substring(0, 2)} / ${d.substring(2)}';
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class _ApplePaySheet extends StatefulWidget {
  const new();

  @override
  State<_ApplePaySheet> createState() => _ApplePaySheetState();
}

class _ApplePaySheetState extends State<_ApplePaySheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.pulse,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Motion.enabled(context)) {
      if (!_c.isAnimating) _c.repeat(reverse: true);
    } else {
      _c.value = 1;
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    // The mock sheet is always black, like the system sheet.
    const sheet = Color(0xFF000000);
    const onSheet = Color(0xFFFFFFFF);
    return Container(
      key: const Key('checkout.applePaySheet'),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: sheet,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
      ),
      child: Column(
        children: <Widget>[
          FadeTransition(
            opacity: Tween<double>(begin: 0.4, end: 1).animate(_c),
            child: const Icon(
              Icons.face_unlock_outlined,
              size: 48,
              color: onSheet,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l.checkoutApplePaySheet,
            style: context.body.copyWith(
              color: onSheet,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l.checkoutApplePayHint,
            textAlign: TextAlign.center,
            style: context.caption.copyWith(
              color: onSheet.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const new({required this.cancelled, required this.onRetry});

  final bool cancelled;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    return Container(
      key: const Key('checkout.error'),
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: c.badSoft,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.error_outline_rounded, color: c.bad),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l.checkoutDeclinedTitle,
                  style: context.body.copyWith(
                    color: c.bad,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  cancelled ? l.checkoutCancelledBody : l.checkoutDeclinedBody,
                  style: context.caption.copyWith(color: c.text),
                ),
              ],
            ),
          ),
          TextButton(
            key: const Key('checkout.retry'),
            onPressed: onRetry,
            style: TextButton.styleFrom(foregroundColor: c.bad),
            child: Text(l.checkoutRetry),
          ),
        ],
      ),
    );
  }
}

class _ThreeDsPage extends StatelessWidget {
  const new({required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        title: Text(l.threeDsTitle),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.verified_user_outlined, size: 56, color: c.brand),
            const SizedBox(height: 16),
            Text(
              l.threeDsBody(amount),
              textAlign: TextAlign.center,
              style: context.body,
            ),
            const Spacer(),
            PrimaryButton(
              key: const Key('3ds.approve'),
              label: l.threeDsApprove,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            const SizedBox(height: 10),
            SecondaryButton(
              key: const Key('3ds.cancel'),
              label: l.threeDsCancel,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}
