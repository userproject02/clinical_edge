import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/logging/activity_logger.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/assessments/domain/assessment.dart';
import 'package:clinical_edge/features/assessments/presentation/assessment_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// `/assess/:quizId/run`: one question at a time with instant feedback
/// (QZ-1), then the result (QZ-2). No bottom navigation.
class QuizScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({required this.quizId, super.key});

  /// Quiz id from the route.
  final String quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(quizRunProvider(quizId)).value;
    final run = ref.read(quizRunProvider(quizId).notifier);

    void exit() => context.go(AppRoutes.assess);

    Future<void> confirmLeave() async {
      if (await confirmLeaveQuiz(context) && context.mounted) exit();
    }

    if (s == null) {
      return AppScaffold.detail(
        title: l.titleQuiz,
        onBack: exit,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 260),
        ),
      );
    }

    final result = s.result;
    return PopScope(
      canPop: !s.inProgress,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) unawaited(confirmLeave());
      },
      child: AppScaffold.detail(
        title: s.quiz.title.of(context),
        onBack: s.inProgress ? confirmLeave : exit,
        bottomBar: result != null
            ? _ResultActions(onDone: exit, onRetake: run.retake)
            : _StickyNext(
                label: s.isLast ? l.quizSeeResults : l.quizNext,
                onPressed: s.answered && !s.submitting ? run.next : null,
                loading: s.submitting,
              ),
        body: result != null
            ? _ResultView(session: s, attempt: result)
            : _QuestionView(session: s, onAnswer: run.answer),
      ),
    );
  }
}

/// Shows the "Leave assessment?" dialog; true when the user chose Leave.
Future<bool> confirmLeaveQuiz(BuildContext context) async {
  final l = AppLocalizations.of(context);
  final leave = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      key: const Key('quiz.leaveDialog'),
      title: Text(l.quizLeaveTitle),
      content: Text(l.quizLeaveBody),
      actions: <Widget>[
        TextButton(
          key: const Key('quiz.leave.stay'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l.quizLeaveStay),
        ),
        TextButton(
          key: const Key('quiz.leave.confirm'),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l.quizLeaveConfirm),
        ),
      ],
    ),
  );
  return leave ?? false;
}

// --- Question -------------------------------------------------------------

class _QuestionView extends StatelessWidget {
  const new({required this.session, required this.onAnswer});

  final QuizSession session;
  final ValueChanged<int> onAnswer;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = session;
    final q = s.current;
    final chosen = s.answers[s.index];
    final letters = l.quizOptionLetters.split('|');
    return ListView(
      key: const Key('quiz.list'),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                l.quizQuestionOf(
                  Formats.integer(s.index + 1),
                  Formats.integer(s.questions.length),
                ),
                key: const Key('quiz.counter'),
                style: context.caption.copyWith(
                  color: context.colors.muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            StatusTag(
              label: l.quizPassTag(Formats.percent(s.quiz.passMarkPct)),
              tone: StatusTone.brand,
            ),
          ],
        ),
        const SizedBox(height: 10),
        _SegmentBar(session: s),
        const SizedBox(height: 18),
        Text(
          q.prompt.of(context),
          key: Key('quiz.prompt.${q.id}'),
          style: context.sectionTitle,
        ),
        const SizedBox(height: 16),
        for (final (i, option) in q.options.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _OptionButton(
              key: Key('quiz.option.$i'),
              letter: i < letters.length ? letters[i] : '${i + 1}',
              text: option.of(context),
              state: chosen == null
                  ? _OptionState.idle
                  : i == q.correctIndex
                  ? _OptionState.correct
                  : i == chosen
                  ? _OptionState.wrong
                  : _OptionState.dimmed,
              onTap: chosen == null ? () => onAnswer(i) : null,
            ),
          ),
        if (chosen != null)
          FadeUpIn(
            key: Key('quiz.explanation.${q.id}'),
            child: _ExplanationCard(
              correct: chosen == q.correctIndex,
              text: q.explanation.of(context),
            ),
          ),
      ],
    );
  }
}

class _SegmentBar extends StatelessWidget {
  const new({required this.session});

  final QuizSession session;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final s = session;
    return Semantics(
      label: l.quizProgressSemantics(
        s.answers.where((a) => a != null).length,
        s.questions.length,
      ),
      child: ExcludeSemantics(
        child: Row(
          children: <Widget>[
            for (final (i, q) in s.questions.indexed) ...<Widget>[
              if (i > 0) const SizedBox(width: 4),
              Expanded(
                child: AnimatedContainer(
                  key: Key('quiz.segment.$i'),
                  duration: Motion.duration(context, Motion.listItem),
                  curve: Motion.standard,
                  height: 6,
                  decoration: BoxDecoration(
                    color: s.answers[i] == null
                        ? (i == s.index ? c.brand : c.surface2)
                        : s.answers[i] == q.correctIndex
                        ? c.ok
                        : c.bad,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum _OptionState { idle, correct, wrong, dimmed }

class _OptionButton extends StatelessWidget {
  const new({
    required this.letter,
    required this.text,
    required this.state,
    required this.onTap,
    super.key,
  });

  final String letter;
  final String text;
  final _OptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final (bg, border, badgeBg, badgeFg) = switch (state) {
      _OptionState.correct => (c.okSoft, c.ok, c.ok, c.surface),
      _OptionState.wrong => (c.badSoft, c.bad, c.bad, c.surface),
      _ => (c.surface, c.outline, c.surface2, c.text),
    };
    final button = Semantics(
      button: true,
      selected: state == _OptionState.correct || state == _OptionState.wrong,
      label: l.quizOptionSemantics(letter, text),
      excludeSemantics: true,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: BorderSide(color: border, width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 56),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 12, 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: badgeBg,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      letter,
                      style: context.caption.copyWith(
                        color: badgeFg,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(text, style: context.body)),
                  if (state == _OptionState.correct) ...<Widget>[
                    const SizedBox(width: 8),
                    _AnimatedCheck(color: c.ok),
                  ],
                  if (state == _OptionState.wrong) ...<Widget>[
                    const SizedBox(width: 8),
                    Icon(Icons.close_rounded, color: c.bad, size: 22),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return AnimatedOpacity(
      opacity: state == _OptionState.dimmed ? 0.55 : 1,
      duration: Motion.duration(context, Motion.listItem),
      child: Shake(trigger: state == _OptionState.wrong ? 1 : 0, child: button),
    );
  }
}

/// Check mark drawn stroke by stroke over [Motion.checkDraw].
class _AnimatedCheck extends StatelessWidget {
  const new({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: const Key('quiz.check'),
      tween: Tween<double>(begin: 0, end: 1),
      duration: Motion.duration(context, Motion.checkDraw),
      curve: Motion.standard,
      builder: (context, t, _) => CustomPaint(
        size: const Size.square(22),
        painter: _CheckPainter(progress: t, color: color),
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  new({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.52)
      ..lineTo(size.width * 0.42, size.height * 0.74)
      ..lineTo(size.width * 0.82, size.height * 0.3);
    final metric = path.computeMetrics().first;
    canvas.drawPath(
      metric.extractPath(0, metric.length * progress),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.6
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_CheckPainter old) =>
      old.progress != progress || old.color != color;
}

class _ExplanationCard extends StatelessWidget {
  const new({required this.correct, required this.text});

  final bool correct;
  final String text;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final tone = correct ? StatusTone.ok : StatusTone.bad;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: BorderDirectional(
          start: BorderSide(color: tone.foreground(c), width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                correct ? Icons.check_circle_rounded : Icons.info_rounded,
                color: tone.foreground(c),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                correct ? l.quizCorrect : l.quizNotQuite,
                style: context.cardTitle.copyWith(color: tone.foreground(c)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(l.quizExplanation(text), style: context.body),
        ],
      ),
    );
  }
}

class _StickyBar extends StatelessWidget {
  const new({required this.child});

  final Widget child;

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
          child: child,
        ),
      ),
    );
  }
}

class _StickyNext extends StatelessWidget {
  const new({
    required this.label,
    required this.onPressed,
    required this.loading,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) => _StickyBar(
    child: PrimaryButton(
      key: const Key('quiz.next'),
      label: label,
      loading: loading,
      onPressed: onPressed,
    ),
  );
}

// --- Result ---------------------------------------------------------------

class _ResultView extends StatelessWidget {
  const new({required this.session, required this.attempt});

  final QuizSession session;
  final QuizAttempt attempt;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final passed = attempt.passed;
    final tone = passed ? StatusTone.ok : StatusTone.warn;
    final pct = Formats.percent(attempt.scorePct);
    return ListView(
      key: const Key('quiz.result'),
      padding: const EdgeInsetsDirectional.fromSTEB(24, 28, 24, 24),
      children: <Widget>[
        Center(
          child: ProgressRing(
            key: const Key('result.ring'),
            value: attempt.scorePct / 100,
            size: 168,
            strokeWidth: 14,
            color: tone.foreground(c),
            label: pct,
            labelStyle: context.screenTitle.copyWith(
              fontSize: 40,
              color: tone.foreground(c),
              letterSpacing: 0,
            ),
            semanticLabel: l.resultScoreSemantics(pct),
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: Text(
            l.resultCorrectCount(
              Formats.integer(session.correct),
              Formats.integer(session.questions.length),
            ),
            key: const Key('result.count'),
            style: context.body.copyWith(
              color: c.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: StatusTag(
            key: const Key('result.tag'),
            label: passed ? l.resultPassedTag : l.resultBelowTag,
            tone: tone,
            icon: passed ? Icons.check_rounded : Icons.error_outline_rounded,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          passed ? l.resultPassedTitle : l.resultFailedTitle,
          key: const Key('result.title'),
          textAlign: TextAlign.center,
          style: context.screenTitle,
        ),
        const SizedBox(height: 6),
        Text(
          passed
              ? l.resultPassedBody
              : l.resultFailedBody(Formats.percent(session.quiz.passMarkPct)),
          textAlign: TextAlign.center,
          style: context.body.copyWith(color: c.muted),
        ),
        const SizedBox(height: 20),
        Container(
          key: const Key('result.audit'),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.verified_user_outlined, size: 18, color: c.brand),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l.resultAudit,
                  style: context.caption.copyWith(color: c.text),
                ),
              ),
              LtrText(
                AuditAction.quizScore.wire,
                style: context.mono.copyWith(color: c.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResultActions extends StatelessWidget {
  const new({required this.onDone, required this.onRetake});

  final VoidCallback onDone;
  final Future<void> Function() onRetake;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return _StickyBar(
      child: Row(
        children: <Widget>[
          Expanded(
            child: SecondaryButton(
              key: const Key('result.retake'),
              label: l.resultRetake,
              icon: Icons.refresh_rounded,
              onPressed: () => unawaited(onRetake()),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PrimaryButton(
              key: const Key('result.done'),
              label: l.resultDone,
              onPressed: onDone,
            ),
          ),
        ],
      ),
    );
  }
}
