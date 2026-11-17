import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:material_ui/material_ui.dart';

/// 52 dp stadium button filled with the brand colour.
///
/// While [loading] is true it shows a spinner in place of the label, keeps
/// its size and ignores taps. Press feedback is an ink ripple, never a scale
/// (scaling text renders blurry).
class PrimaryButton extends StatelessWidget {
  /// Creates the button.
  const new({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
    super.key,
  });

  /// Button text.
  final String label;

  /// Tap handler; null disables the button.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Shows the loading state.
  final bool loading;

  /// Fills the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final enabled = onPressed != null && !loading;
    return _ButtonFrame(
      expand: expand,
      label: label,
      loading: loading,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          backgroundColor: c.brand,
          foregroundColor: c.onBrand,
          disabledBackgroundColor: loading
              ? c.brand
              : c.brand.withValues(alpha: 0.45),
          disabledForegroundColor: c.onBrand.withValues(
            alpha: loading ? 1 : 0.8,
          ),
          shape: const StadiumBorder(),
          textStyle: context.cardTitle.copyWith(letterSpacing: 0),
        ),
        child: _ButtonContent(
          label: label,
          icon: icon,
          loading: loading,
          spinnerColor: c.onBrand,
        ),
      ),
    );
  }
}

/// 52 dp stadium outlined button for secondary actions.
class SecondaryButton extends StatelessWidget {
  /// Creates the button.
  const new({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
    super.key,
  });

  /// Button text.
  final String label;

  /// Tap handler; null disables the button.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Shows the loading state.
  final bool loading;

  /// Fills the available width.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final enabled = onPressed != null && !loading;
    return _ButtonFrame(
      expand: expand,
      label: label,
      loading: loading,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 52),
          backgroundColor: c.surface,
          foregroundColor: c.brand,
          disabledForegroundColor: loading
              ? c.brand
              : c.muted.withValues(alpha: 0.7),
          side: BorderSide(color: c.outline, width: 1.5),
          shape: const StadiumBorder(),
          textStyle: context.cardTitle.copyWith(letterSpacing: 0),
        ),
        child: _ButtonContent(
          label: label,
          icon: icon,
          loading: loading,
          spinnerColor: c.brand,
        ),
      ),
    );
  }
}

class _ButtonFrame extends StatelessWidget {
  const new({
    required this.expand,
    required this.label,
    required this.loading,
    required this.child,
  });

  final bool expand;
  final String label;
  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final framed = SizedBox(
      width: expand ? double.infinity : null,
      height: 52,
      child: child,
    );
    if (!loading) return framed;
    return Semantics(
      label: '$label, ${AppLocalizations.of(context).loading}',
      excludeSemantics: true,
      button: true,
      enabled: false,
      child: framed,
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const new({
    required this.label,
    required this.icon,
    required this.loading,
    required this.spinnerColor,
  });

  final String label;
  final IconData? icon;
  final bool loading;
  final Color spinnerColor;

  @override
  Widget build(BuildContext context) {
    // The label stays in the tree (invisible) while loading so the button
    // keeps its width and does not jump.
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: loading ? 0 : 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (loading)
          SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: spinnerColor,
              backgroundColor: const Color(0x00000000),
              strokeCap: StrokeCap.round,
            ),
          ),
      ],
    );
  }
}
