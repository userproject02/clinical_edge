import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/role.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/presentation/role_labels.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// One topic of the user guide: icon, title and steps (one per line).
typedef HelpTopic = ({String id, IconData icon, String title, String body});

/// The guide for [role], in reading order.
List<HelpTopic> helpTopicsFor(AppLocalizations l, Role role) {
  final bell = switch (role) {
    Role.learner => l.helpLearnerBellBody,
    Role.supervisor => l.helpSupervisorBellBody,
    Role.admin => l.helpAdminBellBody,
  };
  return <HelpTopic>[
    ...switch (role) {
      Role.learner => <HelpTopic>[
        (
          id: 'home',
          icon: Icons.home_rounded,
          title: l.helpLearnerHomeTitle,
          body: l.helpLearnerHomeBody,
        ),
        (
          id: 'learn',
          icon: Icons.menu_book_rounded,
          title: l.helpLearnerLearnTitle,
          body: l.helpLearnerLearnBody,
        ),
        (
          id: 'assess',
          icon: Icons.fact_check_rounded,
          title: l.helpLearnerAssessTitle,
          body: l.helpLearnerAssessBody,
        ),
        (
          id: 'certs',
          icon: Icons.workspace_premium_rounded,
          title: l.helpLearnerCertsTitle,
          body: l.helpLearnerCertsBody,
        ),
        (
          id: 'signoffs',
          icon: Icons.assignment_turned_in_rounded,
          title: l.helpLearnerSignoffsTitle,
          body: l.helpLearnerSignoffsBody,
        ),
      ],
      Role.supervisor => <HelpTopic>[
        (
          id: 'queue',
          icon: Icons.inbox_rounded,
          title: l.helpSupervisorQueueTitle,
          body: l.helpSupervisorQueueBody,
        ),
        (
          id: 'review',
          icon: Icons.rate_review_rounded,
          title: l.helpSupervisorReviewTitle,
          body: l.helpSupervisorReviewBody,
        ),
        (
          id: 'decided',
          icon: Icons.task_alt_rounded,
          title: l.helpSupervisorDecidedTitle,
          body: l.helpSupervisorDecidedBody,
        ),
        (
          id: 'learn',
          icon: Icons.menu_book_rounded,
          title: l.helpSupervisorLearnTitle,
          body: l.helpSupervisorLearnBody,
        ),
      ],
      Role.admin => <HelpTopic>[
        (
          id: 'cohort',
          icon: Icons.groups_rounded,
          title: l.helpAdminCohortTitle,
          body: l.helpAdminCohortBody,
        ),
        (
          id: 'audit',
          icon: Icons.receipt_long_rounded,
          title: l.helpAdminAuditTitle,
          body: l.helpAdminAuditBody,
        ),
        (
          id: 'insights',
          icon: Icons.insights_rounded,
          title: l.helpAdminInsightsTitle,
          body: l.helpAdminInsightsBody,
        ),
      ],
    },
    (
      id: 'bell',
      icon: Icons.notifications_rounded,
      title: l.helpBellTitle,
      body: bell,
    ),
    (
      id: 'settings',
      icon: Icons.settings_rounded,
      title: l.helpSettingsTitle,
      body: l.helpSettingsBody,
    ),
    (
      id: 'demo',
      icon: Icons.info_outline_rounded,
      title: l.helpDemoTitle,
      body: l.helpDemoBody,
    ),
  ];
}

/// `/help`: the user guide for the signed-in role (all roles, pushed from
/// Profile & settings).
class HelpScreen extends ConsumerWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(sessionProvider).value;
    if (session == null) return const SizedBox.shrink();
    final role = session.role;
    final intro = switch (role) {
      Role.learner => l.helpIntroLearner,
      Role.supervisor => l.helpIntroSupervisor,
      Role.admin => l.helpIntroAdmin,
    };
    return AppScaffold.detail(
      title: l.titleHelp,
      onBack: () => context.canPop()
          ? context.pop()
          : context.go(AppRoutes.homeFor(role)),
      body: SectionList(
        key: const Key('help.list'),
        sections: <Widget>[
          _Intro(role: roleLabel(l, role), text: intro),
          for (final t in helpTopicsFor(l, role)) _TopicCard(topic: t),
        ],
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const new({required this.role, required this.text});

  final String role;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    return Container(
      key: const Key('help.intro'),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.hero,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: c.onHero.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadii.pill),
            ),
            child: Text(
              l.helpGuideFor(role),
              style: context.micro.copyWith(color: c.onHero),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: context.body.copyWith(color: c.onHero, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const new({required this.topic});

  final HelpTopic topic;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final steps = topic.body
        .split('\n')
        .where((s) => s.trim().isNotEmpty)
        .toList();
    return Container(
      key: Key('help.topic.${topic.id}'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              ExcludeSemantics(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c.brandSoft,
                    borderRadius: BorderRadius.circular(AppRadii.chip),
                  ),
                  child: Icon(topic.icon, size: 20, color: c.brand),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(topic.title, style: context.cardTitle),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final (i, step) in steps.indexed) ...<Widget>[
            if (i > 0) const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (steps.length > 1)
                  ExcludeSemantics(
                    child: Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsetsDirectional.only(end: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: c.surface2,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${i + 1}',
                        style: context.micro.copyWith(color: c.brand),
                      ),
                    ),
                  ),
                Expanded(
                  child: Text(step, style: context.body.copyWith(height: 1.4)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
