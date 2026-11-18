import 'dart:async';

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/notifications/domain/inbox_item.dart';
import 'package:clinical_edge/features/notifications/presentation/inbox_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Bell: opens the notifications sheet; tapping an item closes the sheet and
/// goes to its screen.
Future<void> showInbox(BuildContext context) async {
  final route = await showAppBottomSheet<String>(
    context: context,
    builder: (_) => const InboxSheet(),
  );
  if (route != null && context.mounted) context.go(route);
}

/// Sheet listing [inboxProvider]'s items. Items not seen before carry a
/// "New" tag; opening the sheet marks everything seen (clears the bell dot).
class InboxSheet extends ConsumerStatefulWidget {
  /// Creates the sheet.
  const new({super.key});

  @override
  ConsumerState<InboxSheet> createState() => _InboxSheetState();
}

class _InboxSheetState extends ConsumerState<InboxSheet> {
  /// Unseen ids when the sheet opened (kept so "New" tags stay put).
  Set<String>? _fresh;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = ref.watch(inboxProvider).value;
    if (items != null && _fresh == null) {
      final seen = ref.read(inboxSeenProvider);
      _fresh = <String>{
        for (final i in items)
          if (!seen.contains(i.id)) i.id,
      };
      // Mark seen after this frame (providers can't change during build).
      unawaited(
        Future<void>.microtask(() {
          if (mounted) {
            ref.read(inboxSeenProvider.notifier).markAll(_fresh!);
          }
        }),
      );
    }
    final maxHeight = MediaQuery.sizeOf(context).height * 0.7;
    return AppBottomSheet(
      key: const Key('inbox.sheet'),
      title: l.inboxTitle,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: switch (items) {
          null => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SkeletonBox(height: 64),
                SizedBox(height: 10),
                SkeletonBox(height: 64),
              ],
            ),
          ),
          [] => EmptyState(
            key: const Key('inbox.empty'),
            icon: Icons.notifications_none_rounded,
            title: l.inboxEmptyTitle,
            message: l.inboxEmptyBody,
          ),
          final list => ListView.separated(
            key: const Key('inbox.list'),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, i) => _InboxTile(
              item: list[i],
              fresh: _fresh?.contains(list[i].id) ?? false,
            ),
          ),
        },
      ),
    );
  }
}

class _InboxTile extends StatelessWidget {
  const new({required this.item, required this.fresh});

  final InboxItem item;
  final bool fresh;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final l = AppLocalizations.of(context);
    final (icon, fg, bg) = _look(c, item.kind);
    return Semantics(
      button: true,
      child: Material(
        color: c.surface2,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: InkWell(
          key: Key('inbox.item.${item.id}'),
          borderRadius: BorderRadius.circular(AppRadii.card),
          onTap: () => Navigator.of(context).pop(item.route),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 56),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 8, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ExcludeSemantics(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: bg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 20, color: fg),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: context.body.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.body,
                          style: context.caption.copyWith(color: c.muted),
                        ),
                        if (fresh) ...<Widget>[
                          const SizedBox(height: 6),
                          StatusTag(label: l.inboxNew, tone: StatusTone.brand),
                        ],
                      ],
                    ),
                  ),
                  ExcludeSemantics(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 8),
                      child: Icon(Icons.chevron_right_rounded, color: c.muted),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static (IconData, Color, Color) _look(AppColors c, InboxKind kind) =>
      switch (kind) {
        InboxKind.certExpired => (Icons.event_busy_rounded, c.bad, c.badSoft),
        InboxKind.certExpiring => (Icons.schedule_rounded, c.warn, c.warnSoft),
        InboxKind.certVerifying => (
          Icons.hourglass_top_rounded,
          c.blue,
          c.blueSoft,
        ),
        InboxKind.signOffApproved => (Icons.verified_rounded, c.ok, c.okSoft),
        InboxKind.signOffRejected => (
          Icons.edit_note_rounded,
          c.warn,
          c.warnSoft,
        ),
        InboxKind.signOffRequest => (
          Icons.assignment_ind_rounded,
          c.brand,
          c.brandSoft,
        ),
        InboxKind.cohortExpiry => (Icons.badge_rounded, c.warn, c.warnSoft),
        InboxKind.cohortPending => (
          Icons.pending_actions_rounded,
          c.blue,
          c.blueSoft,
        ),
      };
}
