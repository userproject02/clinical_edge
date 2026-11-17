import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/admin/presentation/admin_charts.dart';
import 'package:clinical_edge/features/admin/presentation/admin_providers.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/course_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

/// Tone of a days-to-expiry tag: ≤ 30 bad, ≤ 90 warn, else ok.
StatusTone expiryTone(int days) => days <= 30
    ? StatusTone.bad
    : days <= 90
    ? StatusTone.warn
    : StatusTone.ok;

/// `/cohort`: KPIs, charts and learners (ADM-1).
class CohortScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final stats = ref.watch(cohortStatsProvider).value;
    final learners = ref.watch(cohortLearnersProvider).value;
    final pending = ref.watch(signOffQueueProvider).value;
    final courses = ref.watch(catalogueProvider).value;
    final locale = Localizations.localeOf(context);
    final ready =
        stats != null && learners != null && pending != null && courses != null;
    if (!ready) {
      return TabScaffold(
        title: l.titleCohort,
        isHome: true,
        body: const FirstLoadSkeleton(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SkeletonBox(height: 240),
          ),
        ),
      );
    }
    final k = stats.kpis;
    final depts = {
      for (final d in stats.departments) d.id: d.label.of(context),
    };
    String courseName(String id) =>
        courses.where((x) => x.id == id).firstOrNull?.title.of(context) ?? id;
    Color courseColor(String id) {
      final course = courses.where((x) => x.id == id).firstOrNull;
      return course == null ? c.brand : coverColor(context, course.cover);
    }

    final completion = <BarDatum>[
      for (final p in stats.completionByCourse)
        (
          label: courseName(p.courseId),
          value: p.pct.toDouble(),
          color: courseColor(p.courseId),
          text: Formats.percent(p.pct),
        ),
    ];
    final byDept = <BarDatum>[
      for (final p in stats.progressByDepartment)
        (
          label: depts[p.departmentId] ?? p.departmentId,
          value: p.pct.toDouble(),
          color: c.brand,
          text: Formats.percent(p.pct),
        ),
    ];
    final monthFmt = DateFormat('MMM', locale.toLanguageTag());
    final expiries = <BarDatum>[
      for (final m in stats.expiriesByMonth)
        (
          label: monthFmt.format(DateTime.parse('${m.month}-01')),
          value: m.count.toDouble(),
          color: c.warn,
          text: Formats.integer(m.count),
        ),
    ];
    final expiryTotal = stats.expiriesByMonth.fold(0, (s, m) => s + m.count);
    final maxExpiry = stats.expiriesByMonth.fold(
      0,
      (s, m) => m.count > s ? m.count : s,
    );
    String summary(List<BarDatum> bars) => bars
        .map((b) => '${b.label} ${b.text}')
        .join(', ')
        .replaceAll(RegExp('[\u2066-\u2069]'), '');

    final sections = <Widget>[
      _KpiGrid(
        tiles: <Widget>[
          StatTile(
            key: const Key('cohort.kpi.active'),
            label: l.cohortActive,
            value: Formats.integer(k.activeLearners),
            caption: l.cohortActiveSplit(
              Formats.integer(k.nursing),
              Formats.integer(k.physicians),
            ),
            icon: Icons.groups_outlined,
          ),
          StatTile(
            key: const Key('cohort.kpi.completion'),
            label: l.cohortAvgCompletion,
            value: Formats.percent(k.avgCompletionPct),
            caption: l.cohortDelta(
              ltr(
                '${k.avgCompletionDeltaPts >= 0 ? '+' : ''}'
                '${k.avgCompletionDeltaPts}',
              ),
              k.deltaComparedTo.of(context),
            ),
            icon: Icons.trending_up_rounded,
            tone: StatusTone.ok,
          ),
          StatTile(
            key: const Key('cohort.kpi.expiring'),
            label: l.cohortExpiring,
            value: Formats.integer(k.certsExpiringWithin90Days),
            caption: l.cohortRemindersScheduled,
            icon: Icons.event_busy_outlined,
            tone: StatusTone.warn,
          ),
          StatTile(
            key: const Key('cohort.kpi.pending'),
            label: l.cohortPendingSignoffs,
            value: Formats.integer(pending.length),
            caption: l.cohortSupervisors(Formats.integer(k.supervisors)),
            icon: Icons.fact_check_outlined,
            tone: StatusTone.blue,
          ),
        ],
      ),
      AdminCard(
        key: const Key('cohort.completion'),
        title: l.cohortCompletionByCourse,
        child: HBarList(
          bars: completion,
          semanticLabel: l.chartSemantics(
            l.cohortCompletionByCourse,
            summary(completion),
          ),
        ),
      ),
      AdminCard(
        key: const Key('cohort.departments'),
        title: l.cohortProgressByDept,
        child: VBarChart(
          bars: byDept,
          semanticLabel: l.chartSemantics(
            l.cohortProgressByDept,
            summary(byDept),
          ),
        ),
      ),
      AdminCard(
        key: const Key('cohort.expiries'),
        title: l.cohortExpiries,
        trailing: StatusTag(
          label: l.cohortExpiriesTotal(Formats.integer(expiryTotal)),
          tone: StatusTone.warn,
        ),
        child: VBarChart(
          bars: expiries,
          maxY: (maxExpiry + 2).toDouble(),
          height: 120,
          semanticLabel: l.chartSemantics(l.cohortExpiries, summary(expiries)),
        ),
      ),
      AdminCard(
        key: const Key('cohort.learners'),
        title: l.cohortLearners,
        trailing: Text(
          l.cohortDemoNote(
            stats.demoLabel.of(context),
            Formats.date(stats.asOf, locale),
          ),
          style: context.micro.copyWith(color: c.muted),
        ),
        child: Column(
          children: <Widget>[
            for (final (i, r) in learners.indexed) ...<Widget>[
              if (i > 0) Divider(height: 20, color: c.outline),
              Row(
                key: Key('cohort.learner.${r.user.id}'),
                children: <Widget>[
                  InitialsAvatar(initials: r.user.initials, size: 36),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          r.user.name.of(context),
                          style: context.body.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 64,
                              child: LinearMeter(
                                value: r.pct / 100,
                                height: 6,
                                semanticLabel: r.user.name.of(context),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                l.cohortLearnerLine(
                                  Formats.percent(r.pct),
                                  depts[r.user.department] ?? r.user.department,
                                ),
                                style: context.caption.copyWith(color: c.muted),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (r.expiryCode != null && r.expiryDays != null)
                    StatusTag(
                      key: Key('cohort.learner.${r.user.id}.expiry'),
                      label: l.cohortExpiryTag(
                        r.expiryCode!,
                        Formats.integer(r.expiryDays!),
                      ),
                      tone: expiryTone(r.expiryDays!),
                    )
                  else
                    StatusTag(label: l.cohortNoExpiry, tone: StatusTone.ok),
                ],
              ),
            ],
          ],
        ),
      ),
    ];
    return TabScaffold(
      title: l.titleCohort,
      isHome: true,
      body: FirstLoadSkeleton(
        child: ListView(
          key: const Key('cohort.list'),
          padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
          children: <Widget>[
            for (final (i, w) in sections.indexed) ...<Widget>[
              if (i > 0) const SizedBox(height: 14),
              FadeUpIn(index: i, child: w),
            ],
          ],
        ),
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const new({required this.tiles});

  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      for (var r = 0; r < tiles.length; r += 2) ...<Widget>[
        if (r > 0) const SizedBox(height: 8),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: tiles[r]),
              const SizedBox(width: 8),
              Expanded(
                child: r + 1 < tiles.length ? tiles[r + 1] : const SizedBox(),
              ),
            ],
          ),
        ),
      ],
    ],
  );
}
