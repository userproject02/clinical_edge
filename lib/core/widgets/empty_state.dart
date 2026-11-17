import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:material_ui/material_ui.dart';

/// Centred message for empty lists and placeholder screens: icon in a
/// brand-soft square, title, message and an optional action.
class EmptyState extends StatelessWidget {
  /// Creates the empty state.
  const new({
    required this.title,
    this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
    super.key,
  });

  /// Headline.
  final String title;

  /// Supporting text.
  final String? message;

  /// Illustration icon.
  final IconData icon;

  /// Optional button (e.g. a PrimaryButton).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: c.brandSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: c.brand, size: 28),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.sectionTitle,
            ),
            if (message != null) ...<Widget>[
              const SizedBox(height: 6),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: context.body.copyWith(color: c.muted),
              ),
            ],
            if (action != null) ...<Widget>[
              const SizedBox(height: 18),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
