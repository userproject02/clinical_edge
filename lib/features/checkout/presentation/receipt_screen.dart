import 'dart:async';
import 'dart:math' as math;

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
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/checkout/data/checkout_repository.dart';
import 'package:clinical_edge/features/checkout/presentation/checkout_providers.dart';
import 'package:clinical_edge/features/checkout/presentation/checkout_screen.dart';
import 'package:clinical_edge/features/checkout/presentation/receipt_pdf.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:share_plus/share_plus.dart';

/// Receipt timestamp in Dubai local time: "2026-11-17 09:00".
String receiptTimestamp(DateTime instant) {
  final d = instant.toUtc().add(dubaiOffset);
  String two(int n) => n.toString().padLeft(2, '0');
  return '${d.year}-${two(d.month)}-${two(d.day)} '
      '${two(d.hour)}:${two(d.minute)}';
}

/// Receipt method label.
String receiptMethodLabel(AppLocalizations l, Order o) =>
    o.method == const ApplePayMethod('').name
    ? l.receiptApplePay
    : l.receiptCardMethod(ltr(o.cardLast4 ?? '••••'));

/// `/learn/:courseId/receipt/:orderId` (PAY-2).
class ReceiptScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({required this.courseId, required this.orderId, super.key});

  /// Course id.
  final String courseId;

  /// Order id.
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final order = ref.watch(orderProvider(orderId)).value;
    final seller = ref.watch(sellerProvider).value;
    final course = ref.watch(courseProgressProvider(courseId)).value?.course;
    final user = ref.watch(sessionProvider).value?.user;
    void back() => context.go(AppRoutes.learn);
    if (order == null || seller == null || course == null || user == null) {
      return AppScaffold.detail(
        title: l.titleReceipt,
        onBack: back,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 300),
        ),
      );
    }
    final invoice = l.receiptInvoice(
      ltr(order.invoiceNo ?? ''),
      ltr(receiptTimestamp(order.paidAt ?? order.createdAt)),
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) back();
      },
      child: AppScaffold.detail(
        title: l.titleReceipt,
        onBack: back,
        bottomBar: DecoratedBox(
          decoration: BoxDecoration(
            color: c.surface,
            border: Border(top: BorderSide(color: c.outline)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SecondaryButton(
                      key: const Key('receipt.share'),
                      label: l.receiptShare,
                      icon: Icons.ios_share_rounded,
                      onPressed: () => unawaited(
                        _share(
                          context,
                          order,
                          seller,
                          course.title.en,
                          user.name.en,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      key: const Key('receipt.start'),
                      label: l.receiptStart,
                      onPressed: () =>
                          context.go(AppRoutes.lesson(courseId, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          key: const Key('receipt.list'),
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 24),
          children: <Widget>[
            const Center(child: _SuccessBurst()),
            const SizedBox(height: 14),
            Text(
              l.receiptSuccess,
              textAlign: TextAlign.center,
              style: context.screenTitle,
            ),
            const SizedBox(height: 4),
            Text(
              invoice,
              key: const Key('receipt.invoice'),
              textAlign: TextAlign.center,
              style: context.caption.copyWith(color: c.muted),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(AppRadii.cardLarge),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AmountRow(
                    key: const Key('receipt.seller'),
                    label: l.receiptSeller,
                    value: l.receiptSellerValue(
                      seller.name.of(context),
                      ltr(seller.trn),
                    ),
                  ),
                  AmountRow(
                    label: l.receiptBilledTo,
                    value: user.name.of(context),
                  ),
                  AmountRow(
                    label: l.receiptItem,
                    value: course.title.of(context),
                  ),
                  AmountRow(
                    key: const Key('receipt.method'),
                    label: l.receiptMethod,
                    value: receiptMethodLabel(l, order),
                  ),
                  const SizedBox(height: 6),
                  Divider(height: 1, color: c.outline),
                  const SizedBox(height: 6),
                  AmountRow(
                    label: l.checkoutSubtotal,
                    value: Money(order.subtotalFils).format(l),
                  ),
                  AmountRow(
                    label: l.receiptVat(Formats.percent(vatPercent)),
                    value: Money(order.vatFils).format(l),
                  ),
                  AmountRow(
                    key: const Key('receipt.total'),
                    label: l.receiptTotalPaid,
                    value: Money(order.totalFils).format(l),
                    strong: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _share(
    BuildContext context,
    Order order,
    Seller seller,
    String item,
    String buyer,
  ) async {
    final box = context.findRenderObject() as RenderBox?;
    final l = lookupAppLocalizations(const Locale('en'));
    final bytes = await buildReceiptPdf(
      order: order,
      sellerName: seller.name.en,
      sellerTrn: seller.trn,
      buyer: buyer,
      item: item,
      method: receiptMethodLabel(
        l,
        order,
      ).replaceAll(RegExp('[\u2066-\u2069]'), ''),
      timestamp: receiptTimestamp(order.paidAt ?? order.createdAt),
    );
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[
          XFile.fromData(
            bytes,
            name: '${order.invoiceNo ?? 'receipt'}.pdf',
            mimeType: 'application/pdf',
          ),
        ],
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }
}

/// Ring burst + check drawing (respects reduced motion).
class _SuccessBurst extends StatefulWidget {
  const new();

  @override
  State<_SuccessBurst> createState() => _SuccessBurstState();
}

class _SuccessBurstState extends State<_SuccessBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.ringSweep,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!Motion.enabled(context)) {
      _c.value = 1;
    } else if (_c.value == 0 && !_c.isAnimating) {
      _c.forward();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: AppLocalizations.of(context).receiptSuccess,
      child: SizedBox.square(
        dimension: 120,
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) => CustomPaint(
            painter: _BurstPainter(
              t: Motion.standard.transform(_c.value),
              ok: c.ok,
              soft: c.okSoft,
            ),
          ),
        ),
      ),
    );
  }
}

class _BurstPainter extends CustomPainter {
  new({required this.t, required this.ok, required this.soft});

  final double t;
  final Color ok;
  final Color soft;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.width / 2;
    // Burst ring: grows and fades during the first 60 %.
    final burst = (t / 0.6).clamp(0.0, 1.0);
    if (burst < 1) {
      canvas.drawCircle(
        center,
        r * (0.55 + 0.45 * burst),
        Paint()
          ..color = ok.withValues(alpha: 0.35 * (1 - burst))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6,
      );
    }
    // Disc, then the ring sweep.
    canvas
      ..drawCircle(center, r * 0.55, Paint()..color = soft)
      ..drawArc(
        Rect.fromCircle(center: center, radius: r * 0.55),
        -math.pi / 2,
        2 * math.pi * t,
        false,
        Paint()
          ..color = ok
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round,
      );
    // Check drawn during the last 50 %.
    final check = ((t - 0.5) / 0.5).clamp(0.0, 1.0);
    if (check > 0) {
      final path = Path()
        ..moveTo(center.dx - r * 0.22, center.dy + r * 0.01)
        ..lineTo(center.dx - r * 0.06, center.dy + r * 0.16)
        ..lineTo(center.dx + r * 0.24, center.dy - r * 0.14);
      final m = path.computeMetrics().first;
      canvas.drawPath(
        m.extractPath(0, m.length * check),
        Paint()
          ..color = ok
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
  }

  @override
  bool shouldRepaint(_BurstPainter old) => old.t != t || old.ok != ok;
}
