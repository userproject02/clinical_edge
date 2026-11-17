import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/assessments/presentation/assessment_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// `/assess`: quiz cards, stats and score history (QZ-3).
class AssessScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final cards = ref.watch(quizCardsProvider).value;
    if (cards == null) {
      return TabScaffold(
        title: l.titleAssessments,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 220),
        ),
      );
    }
    final open = cards.where((c) => c.unlocked).toList();
    final locked = cards.where((c) => !c.unlocked).toList();
    final history = <QuizAttempt>[for (final c in cards) ...c.attempts]
      ..sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
    final multiQuiz = history.map((a) => a.quizId).toSet().length > 1;
    final titles = {for (final c in cards) c.quiz.id: c.quiz.title.of(context)};

    final children = <Widget>[
      for (final c in open) _QuizCard(data: c),
      _History(history: history, titles: multiQuiz ? titles : null),
      for (final c in locked) _LockedCard(data: c),
    ];
    return TabScaffold(
      title: l.titleAssessments,
      body: SectionList(key: const Key('assess.list'), sections: children),
    );
  }
}

class _Card extends StatelessWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.colors.surface,
      borderRadius: BorderRadius.circular(AppRadii.cardLarge),
    ),
    child: child,
  );
}

class _IconTile extends StatelessWidget {
  const new({required this.icon, required this.tone});

  final IconData icon;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: tone.background(c),
        borderRadius: BorderRadius.circular(AppRadii.field),
      ),
      child: Icon(icon, color: tone.foreground(c)),
    );
  }
}

class _QuizCard extends StatelessWidget {
  const new({required this.data});

  final QuizCardData data;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final q = data.quiz;
    final best = data.best;
    return _Card(
      key: Key('assess.card.${q.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const _IconTile(
                icon: Icons.assignment_turned_in_outlined,
                tone: StatusTone.brand,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(q.subject.of(context), style: context.cardTitle),
                    const SizedBox(height: 2),
                    Text(
                      l.assessQuestionsFromBank(q.size, data.bankSize),
                      style: context.caption.copyWith(color: c.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: StatTile(
                  label: l.assessPassMark,
                  value: Formats.percent(q.passMarkPct),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatTile(
                  key: Key('assess.best.${q.id}'),
                  label: l.assessBestScore,
                  value: best == null ? '—' : Formats.percent(best),
                  tone: best == null
                      ? StatusTone.neutral
                      : QuizRules.passed(best)
                      ? StatusTone.ok
                      : StatusTone.warn,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatTile(
                  key: Key('assess.attempts.${q.id}'),
                  label: l.assessAttempts,
                  value: Formats.integer(data.attempts.length),
                  tone: StatusTone.neutral,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            key: Key('assess.start.${q.id}'),
            label: l.assessStart,
            icon: Icons.play_arrow_rounded,
            onPressed: () => context.go(AppRoutes.quiz(q.id)),
          ),
        ],
      ),
    );
  }
}

class _History extends StatelessWidget {
  const new({required this.history, required this.titles});

  final List<QuizAttempt> history;

  /// Quiz titles by id when more than one quiz has attempts.
  final Map<String, String>? titles;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final locale = Localizations.localeOf(context);
    return _Card(
      key: const Key('assess.history'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l.assessHistory, style: context.cardTitle),
          const SizedBox(height: 8),
          if (history.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                l.assessNoHistory,
                style: context.caption.copyWith(color: c.muted),
              ),
            ),
          for (final (i, a) in history.indexed) ...<Widget>[
            if (i > 0) Divider(height: 1, color: c.outline),
            Padding(
              key: Key('assess.history.$i'),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          <String>[
                            ?titles?[a.quizId],
                            l.assessAttemptN(attemptNumber(history, a)),
                          ].join(' · '),
                          style: context.body.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          Formats.date(a.submittedAt, locale),
                          style: context.caption.copyWith(color: c.muted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: LinearMeter(
                      value: a.scorePct / 100,
                      height: 6,
                      color: a.passed ? c.ok : c.warn,
                      semanticLabel: l.resultScoreSemantics(
                        Formats.percent(a.scorePct),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  StatusTag(
                    label: Formats.percent(a.scorePct),
                    tone: a.passed ? StatusTone.ok : StatusTone.warn,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LockedCard extends StatelessWidget {
  const new({required this.data});

  final QuizCardData data;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    return _Card(
      key: Key('assess.locked.${data.quiz.id}'),
      child: Row(
        children: <Widget>[
          const _IconTile(
            icon: Icons.lock_outline_rounded,
            tone: StatusTone.neutral,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data.quiz.subject.of(context), style: context.cardTitle),
                const SizedBox(height: 2),
                Text(
                  l.assessUnlocksAfter(data.lessonsToUnlock),
                  style: context.caption.copyWith(color: c.muted),
                ),
                const SizedBox(height: 8),
                // Under the text so it never squeezes the row at large
                // text sizes.
                StatusTag(
                  label: l.assessLocked,
                  icon: Icons.lock_outline_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
