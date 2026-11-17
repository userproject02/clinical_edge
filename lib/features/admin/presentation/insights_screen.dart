import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/admin/presentation/admin_charts.dart';
import 'package:clinical_edge/features/admin/presentation/admin_providers.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/courses/presentation/course_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// `/insights`: usage analytics from the usage store and seed aggregates,
/// never the audit store (ADM-4).
class InsightsScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(
      Future<void>.microtask(() {
        if (mounted) ref.invalidate(usageEventsProvider);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final v = ref.watch(insightsProvider).value;
    final courses = ref.watch(catalogueProvider).value;
    if (v == null || courses == null) {
      return TabScaffold(
        title: l.titleInsights,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 240),
        ),
      );
    }
    final byId = {for (final x in courses) x.id: x};
    String name(String id) => byId[id]?.title.of(context) ?? id;
    Color color(String id) =>
        byId[id] == null ? c.brand : coverColor(context, byId[id]!.cover);
    String clean(String s) => s.replaceAll(RegExp('[\u2066-\u2069]'), '');

    final maxViews = v.courseViews.fold(0, (m, x) => x.views > m ? x.views : m);
    final views = <BarDatum>[
      for (final x in v.courseViews)
        (
          label: name(x.courseId),
          value: x.views.toDouble(),
          color: color(x.courseId),
          text: l.insightsViews(Formats.integer(x.views)),
        ),
    ];
    final drop = <BarDatum>[
      for (final (i, pct) in v.retainedPct.indexed)
        (
          label: l.insightsLessonShort(Formats.integer(i + 1)),
          value: pct.toDouble(),
          color: i + 1 == v.biggestDropLesson ? c.bad : c.brand,
          text: Formats.percent(pct),
        ),
    ];
    final sections = <Widget>[
      AdminCard(
        key: const Key('insights.views'),
        title: l.insightsMostUsed,
        child: HBarList(
          bars: views,
          max: maxViews.toDouble(),
          semanticLabel: l.chartSemantics(
            l.insightsMostUsed,
            clean(views.map((b) => '${b.label} ${b.text}').join(', ')),
          ),
        ),
      ),
      AdminCard(
        key: const Key('insights.dropoff'),
        title: l.insightsDropOff(name(v.dropOffCourseId)),
        trailing: StatusTag(
          key: const Key('insights.dropTag'),
          label: l.insightsLessonTag(Formats.integer(v.biggestDropLesson)),
          tone: StatusTone.bad,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            VBarChart(
              bars: drop,
              semanticLabel: l.chartSemantics(
                l.insightsDropOff(name(v.dropOffCourseId)),
                clean(drop.map((b) => '${b.label} ${b.text}').join(', ')),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.insightsDropCaption,
              style: context.caption.copyWith(color: c.muted),
            ),
          ],
        ),
      ),
      AdminCard(
        key: const Key('insights.pass'),
        title: l.insightsPassRates,
        child: Row(
          children: <Widget>[
            for (final p in v.passRates)
              Expanded(
                child: Column(
                  children: <Widget>[
                    ProgressRing(
                      value: p.pct / 100,
                      size: 72,
                      strokeWidth: 8,
                      color: QuizRules.passed(p.pct) ? c.ok : c.warn,
                      semanticLabel: '${name(p.courseId)} ${p.pct}%',
                    ),
                    const SizedBox(height: 6),
                    Text(
                      name(p.courseId),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.micro.copyWith(color: c.text),
                    ),
                    Text(
                      l.insightsAttempts(Formats.integer(p.attempts ?? 0)),
                      style: context.micro.copyWith(color: c.muted),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      AdminCard(
        key: const Key('insights.platforms'),
        title: l.insightsPlatforms,
        child: _PlatformBar(ios: v.iosPct, android: v.androidPct),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.info_outline_rounded, size: 16, color: c.muted),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l.insightsNote,
              style: context.caption.copyWith(color: c.muted),
            ),
          ),
        ],
      ),
    ];
    return TabScaffold(
      title: l.titleInsights,
      body: SectionList(key: const Key('insights.list'), sections: sections),
    );
  }
}

class _PlatformBar extends StatelessWidget {
  const new({required this.ios, required this.android});

  final int ios;
  final int android;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final iosText = l.platformShare('iOS', Formats.percent(ios));
    final androidText = l.platformShare('Android', Formats.percent(android));
    final label = '$iosText · $androidText';
    return Semantics(
      label: label.replaceAll(RegExp('[\u2066-\u2069]'), ''),
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Motion.duration(context, Motion.barGrow),
              curve: Motion.standard,
              builder: (context, t, _) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 16,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: (ios * t * 10).round().clamp(1, 1000),
                        child: ColoredBox(color: c.brand),
                      ),
                      Expanded(
                        flex: (android * t * 10).round().clamp(1, 1000),
                        child: ColoredBox(color: c.blue),
                      ),
                      Expanded(
                        flex: ((100 - (ios + android) * t) * 10).round().clamp(
                          0,
                          1000,
                        ),
                        child: ColoredBox(color: c.surface2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: <Widget>[
                _Legend(color: c.brand, text: iosText),
                _Legend(color: c.blue, text: androidText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const new({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(text, style: context.caption),
    ],
  );
}
