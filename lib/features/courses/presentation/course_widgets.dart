import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:material_ui/material_ui.dart';

/// Cover colour token of a course.
Color coverColor(BuildContext context, CourseCover cover) {
  final c = context.colors;
  return switch (cover) {
    CourseCover.bls => c.courseBls,
    CourseCover.ipc => c.courseIpc,
    CourseCover.medication => c.courseMedication,
  };
}

/// Cover icon of a course.
IconData coverIcon(CourseCover cover) => switch (cover) {
  CourseCover.bls => Icons.monitor_heart_outlined,
  CourseCover.ipc => Icons.health_and_safety_outlined,
  CourseCover.medication => Icons.medication_outlined,
};

/// Localized lesson type.
String lessonTypeLabel(AppLocalizations l, LessonType t) => switch (t) {
  LessonType.video => l.lessonTypeVideo,
  LessonType.pdf => l.lessonTypePdf,
  LessonType.reading => l.lessonTypeReading,
};

/// Icon of a lesson type.
IconData lessonTypeIcon(LessonType t) => switch (t) {
  LessonType.video => Icons.play_circle_outline_rounded,
  LessonType.pdf => Icons.picture_as_pdf_outlined,
  LessonType.reading => Icons.article_outlined,
};

/// "3h 20m" / "3 س 20 د".
String durationLabel(AppLocalizations l, int minutes) =>
    l.durationHm(minutes ~/ 60, minutes % 60);

/// Coloured cover block with a gently floating icon.
class CourseCoverArt extends StatefulWidget {
  /// Creates the cover.
  const new({
    required this.cover,
    this.height = 96,
    this.radius = 16,
    this.child,
    super.key,
  });

  /// Cover token.
  final CourseCover cover;

  /// Height.
  final double height;

  /// Top corner radius (bottom corners are square).
  final double radius;

  /// Overlay (e.g. a category tag).
  final Widget? child;

  @override
  State<CourseCoverArt> createState() => _CourseCoverArtState();
}

class _CourseCoverArtState extends State<CourseCoverArt>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Motion.enabled(context)) {
      if (!_c.isAnimating) _c.repeat(reverse: true);
    } else {
      _c.stop();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = coverColor(context, widget.cover);
    final on = context.colors.onHero;
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.radius),
        ),
      ),
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
            end: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: ExcludeSemantics(
                child: AnimatedBuilder(
                  animation: _c,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(
                      0,
                      -8 * Curves.easeInOut.transform(_c.value),
                    ),
                    child: child,
                  ),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: on.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(coverIcon(widget.cover), color: on, size: 26),
                  ),
                ),
              ),
            ),
          ),
          if (widget.child != null)
            PositionedDirectional(start: 14, top: 12, child: widget.child!),
        ],
      ),
    );
  }
}

/// Small tag on a coloured cover.
class CoverTag extends StatelessWidget {
  /// Creates the tag.
  const new(this.label, {super.key});

  /// Text.
  final String label;

  @override
  Widget build(BuildContext context) {
    final on = context.colors.onHero;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 3, 10, 3),
      decoration: BoxDecoration(
        color: on.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadii.tag),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: on),
      ),
    );
  }
}
