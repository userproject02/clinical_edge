import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Greeting for the hour in Asia/Dubai: before 12 morning, before 17
/// afternoon, otherwise evening.
String greetingFor(DateTime instant, AppLocalizations l) {
  final hour = instant.toUtc().add(dubaiOffset).hour;
  if (hour < 12) return l.greetingMorning;
  if (hour < 17) return l.greetingAfternoon;
  return l.greetingEvening;
}

/// Scaffold for every tab screen: the real tab app bar for the signed-in
/// user (subtitle, title, bell, avatar → `/profile`).
///
/// On a role's home tab ([isHome]) the subtitle is the greeting and the
/// title the user's first name; elsewhere the subtitle is the tenant.
class TabScaffold extends ConsumerWidget {
  /// Creates the scaffold.
  const new({
    required this.title,
    required this.body,
    this.isHome = false,
    this.actions = const <Widget>[],
    super.key,
  });

  /// Screen title (ignored on home, which shows the user's name).
  final String title;

  /// Content.
  final Widget body;

  /// Whether this is the role's home tab.
  final bool isHome;

  /// Extra app bar actions.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(sessionProvider).value;
    final tenant = ref.watch(tenantProvider).value?.of(context) ?? l.tenant;
    final now = ref.watch(clockProvider).now();
    return AppScaffold.tab(
      subtitle: isHome ? greetingFor(now, l) : tenant,
      title: isHome && session != null
          ? session.user.shortName.of(context)
          : title,
      actions: actions,
      hasUnread: true,
      // Phase 6 wires the simulated expiry reminder here.
      onBellPressed: () {},
      avatarInitials: session?.user.initials ?? '',
      onAvatarPressed: () => unawaited(context.push(AppRoutes.profile)),
      body: body,
    );
  }
}

/// Shows skeletons for [firstHomeLoadDelay] on the first home load after
/// sign-in, then [child].
class FirstLoadSkeleton extends ConsumerStatefulWidget {
  /// Creates the wrapper.
  const new({required this.child, super.key});

  /// Loaded content.
  final Widget child;

  @override
  ConsumerState<FirstLoadSkeleton> createState() => _FirstLoadSkeletonState();
}

class _FirstLoadSkeletonState extends ConsumerState<FirstLoadSkeleton> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (ref.read(firstHomeLoadProvider)) {
      _timer = Timer(firstHomeLoadDelay, () {
        if (mounted) ref.read(firstHomeLoadProvider.notifier).done();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!ref.watch(firstHomeLoadProvider)) return widget.child;
    return const Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
      child: Column(
        key: Key('home.skeleton'),
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
}
