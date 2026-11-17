import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/money.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/courses/domain/course_progress.dart';
import 'package:clinical_edge/features/courses/presentation/course_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:clinical_edge/features/home/presentation/home_screen.dart'
    show openCourse;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// `/learn`: catalogue with search and category chips (CRS-1).
class CatalogueScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  ConsumerState<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends ConsumerState<CatalogueScreen> {
  String _query = '';
  String _category = 'all';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final cats = ref.watch(categoriesProvider).value ?? const [];
    final all = ref.watch(courseProgressListProvider).value;
    final locale = Localizations.localeOf(context);
    final q = _query.trim().toLowerCase();
    final shown = all
        ?.where(
          (p) =>
              (_category == 'all' || p.course.category == _category) &&
              (q.isEmpty ||
                  p.course.title.forLocale(locale).toLowerCase().contains(q)),
        )
        .toList();

    return TabScaffold(
      title: l.titleCourses,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
            child: SearchBar(
              key: const Key('catalogue.search'),
              hintText: l.catalogueSearch,
              leading: const Icon(Icons.search_rounded),
              elevation: const WidgetStatePropertyAll<double>(0),
              backgroundColor: WidgetStatePropertyAll<Color>(
                context.colors.surface,
              ),
              side: WidgetStatePropertyAll<BorderSide>(
                BorderSide(color: context.colors.outline),
              ),
              constraints: const BoxConstraints(minHeight: 48),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          FilterChipRow<String>(
            key: const Key('catalogue.chips'),
            selected: _category,
            onSelected: (v) => setState(() => _category = v),
            options: <Segment<String>>[
              Segment(value: 'all', label: l.catalogueAll),
              for (final c in cats)
                Segment(value: c.id, label: c.label.of(context)),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: shown == null
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        SkeletonBox(height: 200),
                        SizedBox(height: 12),
                        SkeletonBox(height: 200),
                      ],
                    ),
                  )
                : shown.isEmpty
                ? EmptyState(
                    icon: Icons.search_off_rounded,
                    title: l.catalogueEmptyTitle,
                    message: l.catalogueEmptyBody,
                  )
                : ListView.separated(
                    key: ValueKey<String>('list-$_category-$q'),
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      16,
                      4,
                      16,
                      24,
                    ),
                    itemCount: shown.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, i) => FadeUpIn(
                      index: i,
                      child: CourseCard(progress: shown[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Catalogue card.
class CourseCard extends ConsumerWidget {
  /// Creates the card.
  const new({required this.progress, super.key});

  /// Course and progress.
  final CourseProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final p = progress;
    final cat = (ref.watch(categoriesProvider).value ?? const [])
        .where((x) => x.id == p.course.category)
        .firstOrNull;
    return Material(
      key: Key('course.${p.course.id}'),
      color: c.surface,
      borderRadius: BorderRadius.circular(AppRadii.card),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openCourse(context, ref, p.course.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CourseCoverArt(
              cover: p.course.cover,
              child: cat == null ? null : CoverTag(cat.label.of(context)),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(p.course.title.of(context), style: context.cardTitle),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: <Widget>[
                      StatusTag(label: l.courseLessons(p.total)),
                      StatusTag(label: durationLabel(l, p.course.durationMin)),
                      StatusTag(
                        label: l.courseCpd(p.course.cpdCredits),
                        tone: StatusTone.brand,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (p.owned)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: LinearMeter(
                            value: p.pct / 100,
                            height: 6,
                            semanticLabel: p.course.title.of(context),
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
                    )
                  else
                    Row(
                      children: <Widget>[
                        Text(
                          Money(p.course.priceFils).format(l),
                          key: Key('course.${p.course.id}.price'),
                          style: context.cardTitle.copyWith(letterSpacing: 0),
                        ),
                        const SizedBox(width: 8),
                        StatusTag(
                          label: l.coursePlusVat,
                          tone: StatusTone.warn,
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
