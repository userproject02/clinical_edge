import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/courses/domain/course_progress.dart';
import 'package:clinical_edge/features/courses/presentation/course_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// CTA label of a course (CRS-2).
String courseCta(AppLocalizations l, CourseProgress p) {
  if (!p.owned) return l.ctaBuy(PriceBreakdown(p.course.price).total.format(l));
  if (p.isComplete) return l.ctaReview;
  if (p.done == 0) return l.ctaStart;
  return l.ctaContinue(p.nextIndex! + 1);
}

/// `/learn/:courseId`: header, progress, lessons, sticky CTA (CRS-2).
class CourseDetailScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({required this.courseId, super.key});

  /// Course id from the route.
  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final p = ref.watch(courseProgressProvider(courseId)).value;
    final c = context.colors;
    if (p == null) {
      return AppScaffold.detail(
        title: l.titleCourseDetail,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 200),
        ),
      );
    }
    final cover = coverColor(context, p.course.cover);
    final learner = ref.watch(sessionProvider).value?.role == Role.learner;
    final cat = (ref.watch(categoriesProvider).value ?? const [])
        .where((x) => x.id == p.course.category)
        .firstOrNull;

    void openLesson(int index) {
      if (!p.owned) {
        context.go(AppRoutes.checkout(courseId));
      } else {
        context.go(AppRoutes.lesson(courseId, index + 1));
      }
    }

    return AppScaffold.detail(
      title: p.course.title.of(context),
      barColor: cover,
      barForeground: c.onHero,
      bottomBar: !learner
          ? null
          : _StickyCta(
              label: courseCta(l, p),
              onPressed: () => openLesson(
                p.isComplete || p.nextIndex == null ? 0 : p.nextIndex!,
              ),
            ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: cover,
            padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 20, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (cat != null) CoverTag(cat.label.of(context)),
                const SizedBox(height: 10),
                Text(
                  p.course.title.of(context),
                  style: context.screenTitle.copyWith(color: c.onHero),
                ),
                const SizedBox(height: 6),
                Text(
                  p.course.blurb.of(context),
                  style: context.body.copyWith(
                    color: c.onHero.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    CoverTag(durationLabel(l, p.course.durationMin)),
                    CoverTag(l.courseCpd(p.course.cpdCredits)),
                    CoverTag(l.courseQuiz),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (p.owned) ...<Widget>[
                  Container(
                    key: const Key('detail.progress'),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: c.surface,
                      borderRadius: BorderRadius.circular(AppRadii.card),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                l.courseYourProgress,
                                style: context.cardTitle,
                              ),
                            ),
                            LtrText(
                              Formats.percent(p.pct),
                              style: context.cardTitle.copyWith(
                                color: c.brand,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearMeter(
                          value: p.pct / 100,
                          semanticLabel: l.courseYourProgress,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l.courseLessonsDone(p.done, p.total),
                          style: context.caption.copyWith(color: c.muted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(l.courseLessonsHeading, style: context.sectionTitle),
                const SizedBox(height: 8),
                for (final (i, lesson) in p.course.lessons.indexed)
                  FadeUpIn(
                    index: i,
                    child: _LessonRow(
                      index: i,
                      progress: p,
                      onTap: learner ? () => openLesson(i) : null,
                      title: lesson.title.of(context),
                      subtitle:
                          '${lessonTypeLabel(l, lesson.type)} · '
                          '${l.minutesShort(lesson.minutes)}',
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

class _LessonRow extends StatelessWidget {
  const new({
    required this.index,
    required this.progress,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final int index;
  final CourseProgress progress;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final p = progress;
    final done = p.owned && p.isDone(index);
    final now = p.owned && !done && p.nextIndex == index;
    final (badgeBg, badgeFg) = done
        ? (c.ok, c.surface)
        : now
        ? (c.brand, c.onBrand)
        : (c.surface2, c.muted);
    final tag = !p.owned
        ? StatusTag(
            label: l.lessonStateLocked,
            icon: Icons.lock_outline_rounded,
          )
        : done
        ? StatusTag(label: l.lessonStateDone, tone: StatusTone.ok)
        : now
        ? StatusTag(label: l.lessonStateNow, tone: StatusTone.brand)
        : StatusTag(label: l.lessonStateTodo);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        key: Key('lesson.row.$index'),
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: badgeBg,
                    shape: BoxShape.circle,
                  ),
                  child: done
                      ? Icon(Icons.check_rounded, size: 18, color: badgeFg)
                      : Text(
                          '${index + 1}',
                          style: context.caption.copyWith(
                            color: badgeFg,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: context.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: context.caption.copyWith(color: c.muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                tag,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StickyCta extends StatelessWidget {
  const new({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.outline)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: PrimaryButton(
            key: const Key('detail.cta'),
            label: label,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
