import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/localized_text.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/competencies/data/competency_repository.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// `/queue`: pending sign-off requests with stats (COMP-2).
class QueueScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final queue = ref.watch(signOffQueueProvider).value;
    final stats = ref.watch(queueStatsProvider).value;
    final users = ref.watch(usersByIdProvider).value;
    final checklists = ref.watch(checklistsByIdProvider).value;
    if (queue == null || stats == null || users == null || checklists == null) {
      return TabScaffold(
        title: l.titleQueue,
        isHome: true,
        body: const FirstLoadSkeleton(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SkeletonBox(height: 220),
          ),
        ),
      );
    }
    final turnaround = stats.turnaroundDays;
    // The queue is the supervisor's home: greeting title and the
    // first-load skeleton like the learner home.
    return TabScaffold(
      title: l.titleQueue,
      isHome: true,
      body: FirstLoadSkeleton(
        child: ListView(
          key: const Key('queue.list'),
          padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: StatTile(
                    key: const Key('queue.stat.pending'),
                    label: l.queueStatPending,
                    value: Formats.integer(stats.pending),
                    tone: StatusTone.warn,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatTile(
                    key: const Key('queue.stat.month'),
                    label: l.queueStatThisMonth,
                    value: Formats.integer(stats.thisMonth),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatTile(
                    key: const Key('queue.stat.turnaround'),
                    label: l.queueStatTurnaround,
                    value: turnaround == null
                        ? '—'
                        : l.queueTurnaroundValue(
                            ltr(turnaround.toStringAsFixed(1)),
                          ),
                    tone: StatusTone.neutral,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (queue.isEmpty)
              const _AllCaughtUp()
            else
              for (final (i, r) in queue.indexed) ...<Widget>[
                if (i > 0) const SizedBox(height: 10),
                FadeUpIn(
                  index: i,
                  child: _QueueCard(
                    request: r,
                    learner: users[r.learnerId],
                    checklist: checklists[r.checklistId],
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }
}

class _QueueCard extends StatelessWidget {
  const new({
    required this.request,
    required this.learner,
    required this.checklist,
  });

  final SignOffRequest request;
  final AppUser? learner;
  final CompetencyChecklist? checklist;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final locale = Localizations.localeOf(context);
    return SignOffCard(
      key: Key('queue.${request.id}'),
      onTap: () => context.go(AppRoutes.review(request.id)),
      child: Row(
        children: <Widget>[
          InitialsAvatar(initials: learner?.initials ?? '?'),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        learner?.name.of(context) ?? request.learnerId,
                        style: context.body.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SignOffTag(status: SignOffStatus.pending),
                  ],
                ),
                Text(
                  learner?.title.of(context) ?? '',
                  style: context.caption.copyWith(color: c.muted),
                ),
                const SizedBox(height: 8),
                Text(
                  checklist?.name.of(context) ?? '',
                  style: context.body.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  l.queueSkillsRequested(
                    checklist?.items.length ?? 0,
                    request.requestedAt == null
                        ? ''
                        : Formats.date(request.requestedAt!, locale),
                  ),
                  style: context.caption.copyWith(color: c.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right_rounded, color: c.muted),
        ],
      ),
    );
  }
}

class _AllCaughtUp extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    return Padding(
      key: const Key('queue.empty'),
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: <Widget>[
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Motion.duration(context, Motion.checkDraw),
            curve: Motion.standard,
            builder: (context, t, _) => Opacity(
              opacity: t,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: c.okSoft,
                  shape: BoxShape.circle,
                ),
                child: CustomPaint(painter: _CheckPainter(t, c.ok)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(l.queueEmptyTitle, style: context.sectionTitle),
          const SizedBox(height: 4),
          Text(
            l.queueEmptyBody,
            textAlign: TextAlign.center,
            style: context.body.copyWith(color: c.muted),
          ),
        ],
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  new(this.progress, this.color);

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.52)
      ..lineTo(size.width * 0.45, size.height * 0.66)
      ..lineTo(size.width * 0.72, size.height * 0.38);
    final m = path.computeMetrics().first;
    canvas.drawPath(
      m.extractPath(0, m.length * progress),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_CheckPainter old) => old.progress != progress;
}

/// `/queue/:requestId`: review a request and decide (COMP-2).
class ReviewScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const new({required this.requestId, super.key});

  /// Request id from the route.
  final String requestId;

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  final _comment = TextEditingController();
  bool _commentError = false;
  bool _busy = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _decide(SignOffRequest request, {required bool approve}) async {
    if (!approve && _comment.text.trim().isEmpty) {
      setState(() => _commentError = true);
      return;
    }
    final l = AppLocalizations.of(context);
    final overlay = Navigator.of(context, rootNavigator: true).overlay!.context;
    final router = GoRouter.of(context);
    setState(() => _busy = true);
    try {
      await ref.read(decideSignOffProvider)(
        request,
        approve: approve,
        comment: _comment.text,
      );
    } on CommentRequiredException {
      if (mounted) setState(() => _commentError = true);
      return;
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    router.go(AppRoutes.queue);
    if (!overlay.mounted) return;
    AppSnackBar.show(
      overlay,
      title: approve ? l.reviewApprovedSnack : l.reviewRejectedSnack,
      tone: approve ? StatusTone.ok : StatusTone.warn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final request = ref.watch(signOffRequestProvider(widget.requestId)).value;
    final users = ref.watch(usersByIdProvider).value;
    final checklists = ref.watch(checklistsByIdProvider).value;
    if (request == null || users == null || checklists == null) {
      return AppScaffold.detail(
        title: l.titleReview,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 260),
        ),
      );
    }
    final learner = users[request.learnerId];
    final checklist = checklists[request.checklistId];
    final pending = request.status == SignOffStatus.pending;
    final locale = Localizations.localeOf(context);
    return AppScaffold.detail(
      title: l.titleReview,
      bottomBar: !pending
          ? null
          : DecoratedBox(
              decoration: BoxDecoration(
                color: c.surface,
                border: Border(top: BorderSide(color: c.outline)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: _RejectButton(
                          onPressed: _busy
                              ? null
                              : () =>
                                    unawaited(_decide(request, approve: false)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ApproveButton(
                          onPressed: _busy
                              ? null
                              : () =>
                                    unawaited(_decide(request, approve: true)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      body: ListView(
        key: const Key('review.list'),
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 24),
        children: <Widget>[
          SignOffCard(
            key: const Key('review.learner'),
            child: Row(
              children: <Widget>[
                InitialsAvatar(initials: learner?.initials ?? '?', size: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        learner?.name.of(context) ?? '',
                        style: context.cardTitle,
                      ),
                      Text(
                        learner?.title.of(context) ?? '',
                        style: context.caption.copyWith(color: c.muted),
                      ),
                      if (request.requestedAt != null)
                        Text(
                          l.queueSkillsRequested(
                            checklist?.items.length ?? 0,
                            Formats.date(request.requestedAt!, locale),
                          ),
                          style: context.caption.copyWith(color: c.muted),
                        ),
                    ],
                  ),
                ),
                SignOffTag(status: request.status),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SignOffCard(
            key: const Key('review.checklist'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  checklist?.name.of(context) ?? '',
                  style: context.cardTitle,
                ),
                const SizedBox(height: 8),
                for (final item in checklist?.items ?? const <LocalizedText>[])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: c.brand,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: c.onBrand,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(item.of(context), style: context.body),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l.reviewObserved,
                          style: context.caption.copyWith(
                            color: c.brand,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (pending) ...<Widget>[
            TextField(
              key: const Key('review.comment'),
              controller: _comment,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) {
                if (_commentError) setState(() => _commentError = false);
              },
              decoration: InputDecoration(
                labelText: l.reviewCommentLabel,
                hintText: l.reviewCommentHint,
                alignLabelWithHint: true,
                errorText: _commentError ? l.reviewCommentRequired : null,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Icon(Icons.lock_outline_rounded, size: 16, color: c.muted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.reviewLockNote,
                    style: context.caption.copyWith(color: c.muted),
                  ),
                ),
              ],
            ),
          ] else if (request.comment != null)
            CommentQuote(
              text: request.comment!.of(context),
              tone: signOffTone(request.status),
            ),
        ],
      ),
    );
  }
}

class _RejectButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        key: const Key('review.reject'),
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: c.bad,
          side: BorderSide(color: c.bad, width: 1.5),
          shape: const StadiumBorder(),
        ),
        icon: const Icon(Icons.close_rounded),
        label: Text(AppLocalizations.of(context).reviewReject),
      ),
    );
  }
}

class _ApproveButton extends StatelessWidget {
  const new({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      height: 52,
      child: FilledButton.icon(
        key: const Key('review.approve'),
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: c.ok,
          foregroundColor: c.surface,
          shape: const StadiumBorder(),
        ),
        icon: const Icon(Icons.check_rounded),
        label: Text(AppLocalizations.of(context).reviewApprove),
      ),
    );
  }
}

/// `/decided`: decided requests, newest first (COMP-2).
class DecidedScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final decided = ref.watch(decidedSignOffsProvider).value;
    final users = ref.watch(usersByIdProvider).value;
    final checklists = ref.watch(checklistsByIdProvider).value;
    final locale = Localizations.localeOf(context);
    if (decided == null || users == null || checklists == null) {
      return TabScaffold(
        title: l.titleDecided,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 220),
        ),
      );
    }
    return TabScaffold(
      title: l.titleDecided,
      body: decided.isEmpty
          ? EmptyState(
              title: l.decidedEmptyTitle,
              message: l.decidedEmptyBody,
              icon: Icons.task_alt_outlined,
            )
          : ListView(
              key: const Key('decided.list'),
              padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
              children: <Widget>[
                for (final (i, r) in decided.indexed) ...<Widget>[
                  if (i > 0) const SizedBox(height: 10),
                  FadeUpIn(
                    index: i,
                    child: SignOffCard(
                      key: Key('decided.$i'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InitialsAvatar(
                                initials: users[r.learnerId]?.initials ?? '?',
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      users[r.learnerId]?.name.of(context) ??
                                          r.learnerId,
                                      style: context.body.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      <String>[
                                        ?checklists[r.checklistId]?.name.of(
                                          context,
                                        ),
                                        if (r.decidedAt != null)
                                          Formats.date(r.decidedAt!, locale),
                                      ].join(' · '),
                                      style: context.caption.copyWith(
                                        color: c.muted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              SignOffTag(status: r.status),
                            ],
                          ),
                          if (r.comment != null) ...<Widget>[
                            const SizedBox(height: 10),
                            CommentQuote(
                              text: r.comment!.of(context),
                              tone: signOffTone(r.status),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
