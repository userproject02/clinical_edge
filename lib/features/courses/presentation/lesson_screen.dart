import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/courses/domain/course.dart';
import 'package:clinical_edge/features/courses/domain/course_progress.dart';
import 'package:clinical_edge/features/courses/domain/mark_lesson_complete.dart';
import 'package:clinical_edge/features/courses/presentation/course_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// `/learn/:courseId/lesson/:n` (1-based n): lesson player (CRS-3, CRS-4).
class LessonScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const new({required this.courseId, required this.number, super.key});

  /// Course id.
  final String courseId;

  /// 1-based lesson number.
  final int number;

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  bool _logged = false;
  bool _busy = false;

  int get _index => widget.number - 1;

  void _go(int index) =>
      context.replace(AppRoutes.lesson(widget.courseId, index + 1));

  Future<void> _complete(CourseProgress p) async {
    final l = AppLocalizations.of(context);
    if (p.isDone(_index)) {
      if (_index < p.total - 1) _go(_index + 1);
      return;
    }
    setState(() => _busy = true);
    final complete = ref.read(completeLessonProvider);
    final rootOverlay = Overlay.of(context, rootOverlay: true).context;
    final result = await complete(p.course, _index);
    if (!mounted) return;
    setState(() => _busy = false);
    if (result == LessonCompletion.courseComplete) {
      if (!rootOverlay.mounted) return;
      AppSnackBar.show(
        rootOverlay,
        title: l.courseCompleteTitle,
        message: l.courseCompleteBody(p.course.cpdCredits),
        bottomInset: 96,
      );
      return;
    }
    if (_index < p.total - 1) _go(_index + 1);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final p = ref.watch(courseProgressProvider(widget.courseId)).value;
    if (p == null || _index < 0 || _index >= p.total) {
      return AppScaffold.detail(
        title: l.titleLesson,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 220),
        ),
      );
    }
    if (!_logged) {
      _logged = true;
      ref.read(logLessonViewProvider)(p.course, _index);
    }
    final lesson = p.course.lessons[_index];
    final done = p.isDone(_index);
    final last = _index == p.total - 1;
    final cta = !done
        ? l.lessonMarkComplete
        : last
        ? l.lessonCompleted
        : l.lessonNext;

    return AppScaffold.detail(
      title: p.course.title.of(context),
      barColor: c.hero,
      barForeground: c.onHero,
      onBack: () => context.canPop()
          ? context.pop()
          : context.go(AppRoutes.course(widget.courseId)),
      bottomBar: DecoratedBox(
        decoration: BoxDecoration(
          color: c.surface,
          border: Border(top: BorderSide(color: c.outline)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    key: const Key('lesson.previous'),
                    label: l.lessonPrevious,
                    onPressed: _index == 0 ? null : () => _go(_index - 1),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: PrimaryButton(
                    key: const Key('lesson.complete'),
                    label: cta,
                    icon: done && last ? Icons.check_rounded : null,
                    loading: _busy,
                    onPressed: done && last
                        ? null
                        : () => unawaited(_complete(p)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          switch (lesson.type) {
            LessonType.video => _VideoPanel(minutes: lesson.minutes),
            LessonType.pdf => const _PdfPanel(),
            LessonType.reading => const _ReadingPanel(),
          },
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  l.lessonMeta(
                    widget.number,
                    p.total,
                    lessonTypeLabel(l, lesson.type),
                  ),
                  style: context.caption.copyWith(color: c.muted),
                ),
                const SizedBox(height: 4),
                Text(lesson.title.of(context), style: context.screenTitle),
                const SizedBox(height: 18),
                Text(l.lessonUpNext, style: context.sectionTitle),
                const SizedBox(height: 8),
                for (final (i, x) in p.course.lessons.indexed)
                  _OutlineRow(
                    index: i,
                    title: x.title.of(context),
                    current: i == _index,
                    done: p.isDone(i),
                    onTap: () => _go(i),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlineRow extends StatelessWidget {
  const new({
    required this.index,
    required this.title,
    required this.current,
    required this.done,
    required this.onTap,
  });

  final int index;
  final String title;
  final bool current;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Material(
      color: current ? c.brandSoft : FixedColors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: current ? null : onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  done
                      ? Icons.check_circle_rounded
                      : current
                      ? Icons.play_circle_fill_rounded
                      : Icons.radio_button_unchecked_rounded,
                  size: 20,
                  color: done
                      ? c.ok
                      : current
                      ? c.brand
                      : c.muted,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${index + 1}. $title',
                    style: context.body.copyWith(
                      color: current ? c.brand : c.text,
                      fontWeight: current ? FontWeight.w700 : FontWeight.w400,
                    ),
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

class _VideoPanel extends StatefulWidget {
  const new({required this.minutes});

  final int minutes;

  @override
  State<_VideoPanel> createState() => _VideoPanelState();
}

class _VideoPanelState extends State<_VideoPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scrub = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Motion.enabled(context)) {
      if (!_scrub.isAnimating) _scrub.repeat();
    } else {
      _scrub
        ..stop()
        ..value = 0.35;
    }
  }

  @override
  void dispose() {
    _scrub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    return Container(
      key: const Key('lesson.video'),
      height: 220,
      color: c.hero,
      child: Stack(
        children: <Widget>[
          const PositionedDirectional(
            start: 0,
            end: 0,
            top: 40,
            child: EcgLine(opacity: 0.25),
          ),
          Center(
            child: Semantics(
              button: true,
              label: l.lessonPlay,
              child: SizedBox.square(
                dimension: 68,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    PulsingDot(color: c.onHero, size: 68),
                    Icon(Icons.play_arrow_rounded, color: c.hero, size: 34),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 16,
            end: 16,
            bottom: 14,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: c.onHero.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: AnimatedBuilder(
                      animation: _scrub,
                      builder: (context, _) => FractionallySizedBox(
                        alignment: AlignmentDirectional.centerStart,
                        widthFactor: 0.08 + 0.92 * _scrub.value,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: c.heroAccent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    '${widget.minutes.toString().padLeft(2, '0')}:00',
                    style: context.caption.copyWith(color: c.heroMuted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PdfPanel extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    Widget line(double f) => FractionallySizedBox(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: f,
      child: Container(
        height: 8,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: c.surface2,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
    return Container(
      key: const Key('lesson.pdf'),
      color: c.surface2,
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 16),
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: FixedColors.shadowSoft, blurRadius: 12),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.picture_as_pdf_outlined, color: c.bad),
                const SizedBox(height: 12),
                line(0.7),
                line(1),
                line(0.9),
                line(1),
                line(0.6),
                line(0.85),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l.lessonPdfPlaceholder,
            style: context.caption.copyWith(color: c.muted),
          ),
        ],
      ),
    );
  }
}

class _ReadingPanel extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    return Container(
      key: const Key('lesson.reading'),
      color: c.surface,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l.lessonReadingPlaceholder, style: context.body),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: c.brandSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.lightbulb_outline_rounded, color: c.brand),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.lessonKeyPoint,
                    style: context.body.copyWith(
                      color: c.brand,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(l.lessonFurther, style: context.body.copyWith(color: c.muted)),
        ],
      ),
    );
  }
}
