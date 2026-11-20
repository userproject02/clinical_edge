import 'dart:async';

import 'package:clinical_edge/app/feature_flags.dart';
import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/state/locale.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart' show FadeUpIn;
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/data/auth_repository.dart'
    show InvalidCredentialsException;
import 'package:clinical_edge/features/auth/presentation/role_labels.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Demo password pre-filled on sign-in (any non-empty password works).
const String demoPassword = 'demo-password';

/// `/sign-in`: hero panel + overlapping sign-in card (AUTH-1, AUTH-2).
class SignInScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController(
    text: demoPassword,
  );
  Role _role = Role.learner;
  bool _emailError = false;
  bool _passwordError = false;
  bool _busy = false;
  bool _obscure = true;
  bool _emailEdited = false;
  Map<Role, String> _emails = const <Role, String>{};

  void _pickRole(Role role, Map<Role, String> emails) {
    setState(() {
      _role = role;
      _email.text = emails[role] ?? _email.text;
      _emailEdited = false;
      _emailError = false;
    });
  }

  Future<void> _submit() async {
    final emailEmpty = _email.text.trim().isEmpty;
    final passwordEmpty = _password.text.isEmpty;
    setState(() {
      _emailError = emailEmpty;
      _passwordError = passwordEmpty;
    });
    if (emailEmpty || passwordEmpty) return;
    setState(() => _busy = true);
    try {
      final session = await ref
          .read(sessionProvider.notifier)
          .signIn(
            email: _email.text.trim(),
            password: _password.text,
            role: _role,
          );
      if (mounted) context.go(AppRoutes.homeFor(session.role));
    } on InvalidCredentialsException catch (e) {
      if (mounted) {
        setState(() {
          _emailError = e.emailEmpty;
          _passwordError = e.passwordEmpty;
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final emails = <Role, String>{
      for (final e
          in (ref.watch(demoAccountsProvider).value ?? const {}).entries)
        e.key: e.value.email,
    };
    if (!_emailEdited && _email.text.isEmpty && emails[_role] != null) {
      _email.text = emails[_role]!;
    }
    _emails = emails;
    return Scaffold(
      backgroundColor: c.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _Hero(),
            Transform.translate(
              offset: const Offset(0, -28),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _card(context, c, l),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context, AppColors c, AppLocalizations l) {
    final labelStyle = context.caption.copyWith(
      color: c.muted,
      fontWeight: FontWeight.w600,
    );
    final children = <Widget>[
      Semantics(
        header: true,
        child: Text(
          l.signInTitle,
          style: context.screenTitle.copyWith(fontSize: 20),
        ),
      ),
      _Field(
        label: l.signInEmail,
        labelStyle: labelStyle,
        child: TextField(
          key: const Key('signIn.email'),
          controller: _email,
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const <String>[AutofillHints.username],
          autocorrect: false,
          onChanged: (_) {
            _emailEdited = true;
            if (_emailError) setState(() => _emailError = false);
          },
          decoration: InputDecoration(
            errorText: _emailError ? l.signInEmailRequired : null,
          ),
        ),
      ),
      _Field(
        label: l.signInPassword,
        labelStyle: labelStyle,
        child: TextField(
          key: const Key('signIn.password'),
          controller: _password,
          obscureText: _obscure,
          textDirection: TextDirection.ltr,
          autofillHints: const <String>[AutofillHints.password],
          autocorrect: false,
          enableSuggestions: false,
          onChanged: (_) {
            if (_passwordError) setState(() => _passwordError = false);
          },
          decoration: InputDecoration(
            errorText: _passwordError ? l.signInPasswordRequired : null,
            suffixIcon: IconButton(
              tooltip: _obscure ? l.signInShowPassword : l.signInHidePassword,
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
        ),
      ),
      if (kDemoRoleSwitcher)
        _Field(
          label: l.signInDemoRole,
          labelStyle: labelStyle,
          child: SegmentedPicker<Role>(
            semanticLabel: l.signInDemoRole,
            selected: _role,
            onChanged: (r) => _pickRole(r, _emails),
            segments: <Segment<Role>>[
              for (final r in Role.values)
                Segment(value: r, label: roleLabel(l, r)),
            ],
          ),
        ),
      PrimaryButton(
        key: const Key('signIn.submit'),
        label: l.signInButton,
        loading: _busy,
        onPressed: _submit,
      ),
      Text(
        l.signInDemoNote,
        textAlign: TextAlign.center,
        // 500, not the caption's 400: thin 12 px muted strokes render too
        // light on FreeType (Android, Linux CI) to keep 4.5:1.
        style: context.caption.copyWith(
          color: c.muted,
          fontWeight: FontWeight.w500,
        ),
      ),
    ];
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(18, 22, 18, 22),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadii.hero),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: FixedColors.shadowHero,
            blurRadius: 30,
            offset: Offset(0, 10),
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (var i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(height: 14),
            FadeUpIn(index: i, child: children[i]),
          ],
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const new({
    required this.label,
    required this.labelStyle,
    required this.child,
  });

  final String label;
  final TextStyle labelStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _Hero extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final arabic = Localizations.localeOf(context).languageCode == 'ar';
    return ColoredBox(
      color: c.hero,
      child: Stack(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 24, 56),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppMark(
                        size: 34,
                        background: c.onHero,
                        foreground: c.hero,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              l.appTitle,
                              style: context.sectionTitle.copyWith(
                                color: c.onHero,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              l.brandTag,
                              style: context.micro.copyWith(
                                color: c.heroMuted,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        key: const Key('signIn.language'),
                        onPressed: () => unawaited(
                          ref.read(localeProvider.notifier).toggle(),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(48, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          foregroundColor: c.onHero,
                          side: BorderSide(
                            color: c.onHero.withValues(alpha: 0.35),
                          ),
                          shape: const StadiumBorder(),
                          textStyle: context.caption.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Shows the other language, in that language.
                        child: Text(
                          arabic ? l.languageEnglish : l.languageArabic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    l.heroHeadline,
                    style: context.screenTitle.copyWith(
                      color: c.onHero,
                      fontSize: 30,
                      height: 1.12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l.heroBody,
                    style: context.body.copyWith(color: c.heroMuted),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
