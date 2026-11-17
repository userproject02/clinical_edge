import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';
import 'package:clinical_edge/features/certifications/presentation/cert_providers.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/courses/domain/course_progress.dart';
import 'package:clinical_edge/features/courses/presentation/course_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// `/home`: learner dashboard (HOME-1).
class HomeScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final overview = ref.watch(learnerOverviewProvider).value;
    final certs = ref.watch(myCertificationsProvider).value;
    // Same rule as the reminders and the bell (ReminderService.due).
    final due = ref.watch(dueCertificateProvider).value;
    final config = ref.watch(cpdConfigProvider).value;
    final ledger = ref.watch(cpdLedgerProvider).value;
    final history = ref.watch(quizHistoryProvider).value;
    final checklists = ref.watch(checklistsProvider).value;
    final signoffs = ref.watch(mySignOffsProvider).value;
    final ready = <Object?>[
      overview,
      certs,
      config,
      ledger,
      history,
      checklists,
      signoffs,
    ].every((x) => x != null);

    return TabScaffold(
      title: l.titleHome,
      isHome: true,
      body: FirstLoadSkeleton(
        child: !ready
            ? const _HomeSkeleton()
            : SectionList(
                key: const Key('home.list'),
                sections: <Widget>[
                  _Hero(overview: overview!),
                  if (due case final cert?) _ExpiryAlert(cert: cert),
                  _CpdCard(
                    config: config!,
                    total: ledger!.fold(0, (s, e) => s + e.credits),
                  ),
                  _Carousel(overview: overview),
                  _RecentScores(history: history!),
                  _SignOffs(checklists: checklists!, requests: signoffs!),
                ],
              ),
      ),
    );
  }
}

class _HomeSkeleton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
    child: Column(
      children: <Widget>[
        SkeletonBox(height: 168, radius: 24),
        SizedBox(height: 14),
        SkeletonBox(height: 64),
        SizedBox(height: 14),
        SkeletonBox(height: 84),
        SizedBox(height: 14),
        SkeletonBox(height: 150),
      ],
    ),
  );
}

class _Hero extends StatelessWidget {
  const new({required this.overview});

  final LearnerOverview overview;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final resume = overview.resume;
    return Container(
      key: const Key('home.hero'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.hero,
        borderRadius: BorderRadius.circular(AppRadii.hero),
      ),
      child: Stack(
        children: <Widget>[
          const PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            child: EcgLine(height: 70, opacity: 0.3),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ProgressRing(
                      key: const Key('home.ring'),
                      value: overview.pct / 100,
                      semanticLabel: l.homeOverall,
                      color: c.heroAccent,
                      trackColor: c.onHero.withValues(alpha: 0.18),
                      labelStyle: context.cardTitle.copyWith(
                        color: c.onHero,
                        fontSize: 19,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            l.homeOverall,
                            style: context.caption.copyWith(color: c.heroMuted),
                          ),
                          Text(
                            l.homeLessonsSummary(
                              overview.doneLessons,
                              overview.totalLessons,
                              overview.owned.length,
                            ),
                            style: context.sectionTitle.copyWith(
                              color: c.onHero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    key: const Key('home.resume'),
                    style: FilledButton.styleFrom(
                      backgroundColor: c.onHero,
                      foregroundColor: c.hero,
                      shape: const StadiumBorder(),
                      textStyle: context.body.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: resume == null
                        ? null
                        : () => context.go(
                            AppRoutes.lesson(
                              resume.$1.course.id,
                              resume.$2 + 1,
                            ),
                          ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 18),
                    label: Text(
                      resume == null
                          ? l.homeAllDone
                          : l.homeResume(
                              resume.$1.course.lessons[resume.$2].title.of(
                                context,
                              ),
                            ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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

class _ExpiryAlert extends ConsumerWidget {
  const new({required this.cert});

  final Certification cert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final days = cert.daysLeft(ref.watch(clockProvider));
    final locale = Localizations.localeOf(context);
    return Material(
      color: c.warnSoft,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        key: const Key('home.expiry'),
        borderRadius: BorderRadius.circular(AppRadii.card),
        onTap: () => context.go(AppRoutes.certs),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 12, 14),
          child: Row(
            children: <Widget>[
              PulsingDot(color: c.warn),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l.homeExpiryTitle(
                        cert.code ?? cert.name.of(context),
                        days,
                      ),
                      style: context.body.copyWith(
                        color: c.warn,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      l.homeRenewBefore(Formats.date(cert.expiresOn, locale)),
                      style: context.caption.copyWith(color: c.warn),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: c.warn),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const new({required this.child, this.onTap, super.key});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: context.colors.surface,
    borderRadius: BorderRadius.circular(AppRadii.card),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    ),
  );
}

class _CpdCard extends StatelessWidget {
  const new({required this.config, required this.total});

  final CpdConfig config;
  final int total;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final cycleEnd = DateTime.utc(int.parse(config.cycle), 12, 31);
    final endLabel = Formats.dayMonth(cycleEnd, locale);
    final left = (config.target - total).clamp(0, config.target);
    return _Card(
      key: const Key('home.cpd'),
      onTap: () => context.go(AppRoutes.certs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  l.homeCredits(config.cycle),
                  style: context.caption.copyWith(color: c.muted),
                ),
              ),
              LtrText(
                '$total / ${config.target}',
                key: const Key('home.cpdValue'),
                style: context.cardTitle.copyWith(letterSpacing: 0),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearMeter(
            value: total / config.target,
            semanticLabel: l.homeCredits(config.cycle),
          ),
          const SizedBox(height: 8),
          Text(
            left > 0
                ? l.homeCreditsToGo(left, endLabel)
                : l.homeCreditsReached(endLabel),
            style: context.caption.copyWith(color: c.muted),
          ),
        ],
      ),
    );
  }
}

class _Carousel extends StatelessWidget {
  const new({required this.overview});

  final LearnerOverview overview;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(l.homeContinue, style: context.sectionTitle)),
            TextButton(
              onPressed: () => context.go(AppRoutes.learn),
              child: Text(l.homeViewAll),
            ),
          ],
        ),
        SizedBox(
          height: 206,
          child: ListView.separated(
            key: const Key('home.carousel'),
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            itemCount: overview.owned.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, i) => SizedBox(
              width: 260,
              child: _CarouselCard(progress: overview.owned[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class _CarouselCard extends ConsumerWidget {
  const new({required this.progress});

  final CourseProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final p = progress;
    final tag = p.isComplete
        ? l.courseCompleted
        : l.lessonOfTotal(p.nextIndex! + 1, p.total);
    return Material(
      color: c.surface,
      borderRadius: BorderRadius.circular(AppRadii.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openCourse(context, ref, p.course.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CourseCoverArt(cover: p.course.cover, child: CoverTag(tag)),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    p.course.title.of(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.cardTitle,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LinearMeter(
                          value: p.pct / 100,
                          semanticLabel: p.course.title.of(context),
                          height: 6,
                        ),
                      ),
                      const SizedBox(width: 10),
                      LtrText(
                        Formats.percent(p.pct),
                        style: context.caption.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentScores extends StatelessWidget {
  const new({required this.history});

  final List<QuizAttempt> history;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final last = history.take(4).toList().reversed.toList();
    final locale = Localizations.localeOf(context);
    return _Card(
      key: const Key('home.scores'),
      onTap: () => context.go(AppRoutes.assess),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l.homeRecentScores, style: context.cardTitle),
          const SizedBox(height: 12),
          if (last.isEmpty)
            Text(
              l.homeNoScores,
              style: context.caption.copyWith(color: c.muted),
            )
          else
            Semantics(
              label: l.homeRecentScores,
              value: last.map((a) => '${a.scorePct}%').join(', '),
              excludeSemantics: true,
              child: SizedBox(
                height: 156,
                child: _ScoreBars(
                  scores: <(String, int)>[
                    for (final a in last)
                      (Formats.dayMonth(a.submittedAt, locale), a.scorePct),
                  ],
                  passLabel: l.homePassLine,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ScoreBars extends StatelessWidget {
  const new({required this.scores, required this.passLabel});

  final List<(String, int)> scores;
  final String passLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    const chartH = 96.0;
    return Column(
      children: <Widget>[
        SizedBox(
          height: chartH,
          child: Stack(
            children: <Widget>[
              PositionedDirectional(
                start: 0,
                end: 0,
                bottom: chartH * 0.8,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomPaint(
                        size: const Size.fromHeight(1),
                        painter: _DashPainter(color: c.muted),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      passLabel,
                      style: context.micro.copyWith(color: c.muted),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  for (final (i, (_, s)) in scores.indexed)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: s / 100),
                          duration: Motion.duration(
                            context,
                            Motion.barGrow + Motion.listStagger * (i * 2),
                          ),
                          curve: Motion.standard,
                          builder: (context, v, _) => Container(
                            height: chartH * v,
                            decoration: BoxDecoration(
                              color: s >= 80 ? c.ok : c.brand,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            for (final (d, s) in scores)
              Expanded(
                child: Column(
                  children: <Widget>[
                    LtrText(
                      '$s%',
                      textAlign: TextAlign.center,
                      style: context.caption.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      d,
                      textAlign: TextAlign.center,
                      style: context.micro.copyWith(
                        color: c.muted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _DashPainter extends CustomPainter {
  new({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 7) {
      canvas.drawLine(Offset(x, 0), Offset(x + 4, 0), p);
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}

class _SignOffs extends StatelessWidget {
  const new({required this.checklists, required this.requests});

  final List<CompetencyChecklist> checklists;
  final List<SignOffRequest> requests;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return _Card(
      key: const Key('home.signoffs'),
      onTap: () => context.go(AppRoutes.signoffs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l.homeSignoffs, style: context.cardTitle),
          for (final cl in checklists) ...<Widget>[
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(child: Text(cl.name.of(context), style: context.body)),
                const SizedBox(width: 8),
                signOffTag(
                  l,
                  requests
                          .where((r) => r.checklistId == cl.id)
                          .firstOrNull
                          ?.status ??
                      SignOffStatus.none,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Status tag for a sign-off.
StatusTag signOffTag(AppLocalizations l, SignOffStatus s) => switch (s) {
  SignOffStatus.none => StatusTag(label: l.signoffNone),
  SignOffStatus.pending => StatusTag(
    label: l.signoffPending,
    tone: StatusTone.warn,
  ),
  SignOffStatus.approved => StatusTag(
    label: l.signoffApproved,
    tone: StatusTone.ok,
  ),
  SignOffStatus.rejected => StatusTag(
    label: l.signoffRejected,
    tone: StatusTone.bad,
  ),
};

/// Logs `course.view` and opens the course (in the Learn tab).
void openCourse(BuildContext context, WidgetRef ref, String courseId) {
  ref.read(logCourseViewProvider)(courseId);
  context.go(AppRoutes.course(courseId));
}
