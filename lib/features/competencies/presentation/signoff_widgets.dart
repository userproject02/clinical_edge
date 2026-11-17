import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:material_ui/material_ui.dart';

/// Tone of a sign-off status.
StatusTone signOffTone(SignOffStatus s) => switch (s) {
  SignOffStatus.none => StatusTone.neutral,
  SignOffStatus.pending => StatusTone.warn,
  SignOffStatus.approved => StatusTone.ok,
  SignOffStatus.rejected => StatusTone.bad,
};

/// Label of a sign-off status.
String signOffLabel(AppLocalizations l, SignOffStatus s) => switch (s) {
  SignOffStatus.none => l.signoffNone,
  SignOffStatus.pending => l.signoffPending,
  SignOffStatus.approved => l.signoffApproved,
  SignOffStatus.rejected => l.signoffRejected,
};

/// Status tag for a sign-off.
class SignOffTag extends StatelessWidget {
  /// Creates the tag.
  const new({required this.status, super.key});

  /// Status.
  final SignOffStatus status;

  @override
  Widget build(BuildContext context) => StatusTag(
    label: signOffLabel(AppLocalizations.of(context), status),
    tone: signOffTone(status),
  );
}

/// Rounded white card used across the sign-off screens.
class SignOffCard extends StatelessWidget {
  /// Creates the card.
  const new({required this.child, this.onTap, super.key});

  /// Content.
  final Widget child;

  /// Tap action.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: context.colors.surface,
    borderRadius: BorderRadius.circular(AppRadii.cardLarge),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    ),
  );
}

/// Initials avatar.
class InitialsAvatar extends StatelessWidget {
  /// Creates the avatar.
  const new({required this.initials, this.size = 40, super.key});

  /// Initials ("AR").
  final String initials;

  /// Diameter.
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: c.brandSoft, shape: BoxShape.circle),
      child: Text(
        initials,
        style: context.caption.copyWith(
          color: c.brand,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// A supervisor's comment in a tinted quote card. No quotation marks are
/// added (Arabic does not use curly quotes this way); a start-edge bar
/// marks it as a quote.
class CommentQuote extends StatelessWidget {
  /// Creates the quote.
  const new({required this.text, required this.tone, super.key});

  /// Comment text.
  final String text;

  /// Tone of the bar and tint.
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: tone.background(c),
        borderRadius: BorderRadius.circular(AppRadii.field),
        border: BorderDirectional(
          start: BorderSide(color: tone.foreground(c), width: 3),
        ),
      ),
      child: Text(
        text,
        style: context.body.copyWith(
          color: c.text,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
