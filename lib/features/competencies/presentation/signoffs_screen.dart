import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/competencies/domain/competency.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_widgets.dart';
import 'package:clinical_edge/features/courses/presentation/learning_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Department part of a title ("Consultant · Emergency Medicine" →
/// "Emergency Medicine").
String departmentOf(String title) => title.split(' · ').last;

/// `/signoffs`: the learner's competency checklists (COMP-1).
class SignOffsScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final checklists = ref.watch(checklistsProvider).value;
    final requests = ref.watch(mySignOffsProvider).value;
    final users = ref.watch(usersByIdProvider).value;
    final supervisor = ref.watch(signOffSupervisorProvider).value;
    if (checklists == null || requests == null || users == null) {
      return TabScaffold(
        title: l.titleCompetencies,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonBox(height: 240),
        ),
      );
    }
    return TabScaffold(
      title: l.titleCompetencies,
      body: ListView(
        key: const Key('signoffs.list'),
        padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
        children: <Widget>[
          for (final (i, c) in checklists.indexed) ...<Widget>[
            if (i > 0) const SizedBox(height: 14),
            FadeUpIn(
              index: i,
              child: _ChecklistCard(
                checklist: c,
                request: requests
                    .where((r) => r.checklistId == c.id)
                    .firstOrNull,
                users: users,
                supervisor: supervisor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChecklistCard extends ConsumerStatefulWidget {
  const new({
    required this.checklist,
    required this.request,
    required this.users,
    required this.supervisor,
  });

  final CompetencyChecklist checklist;
  final SignOffRequest? request;
  final Map<String, AppUser> users;
  final AppUser? supervisor;

  @override
  ConsumerState<_ChecklistCard> createState() => _ChecklistCardState();
}

class _ChecklistCardState extends ConsumerState<_ChecklistCard> {
  bool _busy = false;

  Future<void> _request() async {
    final l = AppLocalizations.of(context);
    final overlay = Navigator.of(context, rootNavigator: true).overlay!.context;
    final name = widget.supervisor?.name.of(context) ?? '';
    setState(() => _busy = true);
    try {
      await ref.read(requestSignOffProvider)(widget.checklist);
      if (!overlay.mounted) return;
      AppSnackBar.show(
        overlay,
        title: l.signoffRequestedTitle,
        message: l.signoffRequestedMessage(name),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final cl = widget.checklist;
    final r = widget.request;
    final status = r?.status ?? SignOffStatus.none;
    return SignOffCard(
      key: Key('signoff.${cl.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(cl.name.of(context), style: context.cardTitle),
                    const SizedBox(height: 2),
                    Text(
                      cl.audience.of(context),
                      style: context.caption.copyWith(color: c.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SignOffTag(key: Key('signoff.${cl.id}.status'), status: status),
            ],
          ),
          const SizedBox(height: 12),
          for (final item in cl.items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Semantics(
                    label: l.signoffSelfAssessed,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: c.okSoft,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: c.ok),
                      ),
                      child: Icon(Icons.check_rounded, size: 16, color: c.ok),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item.of(context), style: context.body)),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Divider(height: 1, color: c.outline),
          const SizedBox(height: 12),
          _footer(context, l, status, r),
        ],
      ),
    );
  }

  Widget _footer(
    BuildContext context,
    AppLocalizations l,
    SignOffStatus status,
    SignOffRequest? r,
  ) {
    final c = context.colors;
    final locale = Localizations.localeOf(context);
    switch (status) {
      case SignOffStatus.none:
      case SignOffStatus.rejected:
        final sup = widget.supervisor;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (status == SignOffStatus.rejected && r != null) ...<Widget>[
              _DecidedLine(request: r, users: widget.users),
              const SizedBox(height: 12),
            ],
            PrimaryButton(
              key: Key('signoff.${widget.checklist.id}.request'),
              label: l.signoffRequestAction,
              icon: Icons.send_rounded,
              loading: _busy,
              onPressed: _busy ? null : () => unawaited(_request()),
            ),
            if (sup != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                l.signoffGoesTo(
                  sup.name.of(context),
                  departmentOf(sup.title.of(context)),
                ),
                textAlign: TextAlign.center,
                style: context.caption.copyWith(color: c.muted),
              ),
            ],
          ],
        );
      case SignOffStatus.pending:
        return Row(
          children: <Widget>[
            SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: c.warn,
                // Static arc when motion is reduced (and in goldens).
                value: Motion.enabled(context) ? null : 0.7,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l.signoffWaiting(
                  r?.requestedAt == null
                      ? ''
                      : Formats.date(r!.requestedAt!, locale),
                ),
                style: context.caption.copyWith(color: c.muted),
              ),
            ),
          ],
        );
      case SignOffStatus.approved:
        return _DecidedLine(request: r!, users: widget.users);
    }
  }
}

class _DecidedLine extends StatelessWidget {
  const new({required this.request, required this.users});

  final SignOffRequest request;
  final Map<String, AppUser> users;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final locale = Localizations.localeOf(context);
    final approved = request.status == SignOffStatus.approved;
    final name = users[request.decidedBy]?.name.of(context) ?? '';
    final date = request.decidedAt == null
        ? ''
        : Formats.date(request.decidedAt!, locale);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          approved
              ? l.signoffApprovedBy(name, date)
              : l.signoffReturnedBy(name, date),
          style: context.caption.copyWith(
            color: approved ? c.ok : c.bad,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (request.comment != null) ...<Widget>[
          const SizedBox(height: 8),
          CommentQuote(
            text: request.comment!.of(context),
            tone: approved ? StatusTone.ok : StatusTone.bad,
          ),
        ],
      ],
    );
  }
}
