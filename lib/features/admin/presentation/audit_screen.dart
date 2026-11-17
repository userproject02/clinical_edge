import 'dart:async';
import 'dart:math' as math;

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/screens/tab_scaffold.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/logging/activity_event.dart';
import 'package:clinical_edge/core/logging/audit_chain.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/admin/domain/audit_log.dart';
import 'package:clinical_edge/features/admin/presentation/admin_providers.dart';
import 'package:clinical_edge/features/auth/domain/app_user.dart';
import 'package:clinical_edge/features/competencies/presentation/signoff_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// First 8 characters of a hash.
String shortHash(String? h) =>
    (h ?? '').length <= 8 ? h ?? '' : h!.substring(0, 8);

/// Page size of the event list.
const int auditPageSize = 50;

/// `/audit`: chain banner, filters, events, CSV export (ADM-2, ADM-3).
class AuditScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const new({super.key});

  @override
  ConsumerState<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends ConsumerState<AuditScreen> {
  int _shown = auditPageSize;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Always show the live log when the tab is built.
    unawaited(
      Future<void>.microtask(() {
        if (!mounted) return;
        ref
          ..invalidate(auditEventsProvider)
          ..invalidate(usageEventsProvider);
      }),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _set(AuditFilter f) {
    ref.read(auditFilterStateProvider.notifier).set(f);
    setState(() => _shown = auditPageSize);
  }

  Future<void> _export(List<ActivityEvent> events) async {
    final l = AppLocalizations.of(context);
    final overlay = Navigator.of(context, rootNavigator: true).overlay!.context;
    final box = context.findRenderObject() as RenderBox?;
    final n = await ref.read(exportAuditCsvProvider)(
      events,
      origin: box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    );
    if (!overlay.mounted) return;
    AppSnackBar.show(
      overlay,
      title: l.auditExportReady,
      message: l.auditExportRows(Formats.integer(n)),
      bottomInset: 96,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final filter = ref.watch(auditFilterStateProvider);
    final events = ref.watch(filteredEventsProvider).value;
    final chain = ref.watch(chainResultProvider).value;
    final options = ref.watch(auditFilterOptionsProvider).value;
    final users = ref.watch(usersByIdProvider).value ?? const {};
    return TabScaffold(
      title: l.titleAudit,
      actions: <Widget>[
        IconButton(
          key: const Key('audit.export'),
          tooltip: l.auditExport,
          onPressed: events == null ? null : () => unawaited(_export(events)),
          icon: const Icon(Icons.ios_share_rounded),
        ),
      ],
      body: events == null || chain == null || options == null
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: SkeletonBox(height: 240),
            )
          : RefreshIndicator(
              onRefresh: () async {
                ref
                  ..invalidate(auditEventsProvider)
                  ..invalidate(usageEventsProvider);
                await ref.read(filteredEventsProvider.future);
              },
              child: ListView(
                key: const Key('audit.list'),
                padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 24),
                children: <Widget>[
                  _ChainBanner(result: chain),
                  const SizedBox(height: 12),
                  FilterChipRow<KindFilter>(
                    key: const Key('audit.kind'),
                    padding: EdgeInsets.zero,
                    options: <Segment<KindFilter>>[
                      Segment(value: KindFilter.all, label: l.auditKindAll),
                      Segment(value: KindFilter.audit, label: l.auditKindAudit),
                      Segment(value: KindFilter.usage, label: l.auditKindUsage),
                    ],
                    selected: filter.kind,
                    onSelected: (k) => _set(filter.copyWith(kind: k)),
                  ),
                  const SizedBox(height: 8),
                  FilterChipRow<PeriodFilter>(
                    key: const Key('audit.period'),
                    padding: EdgeInsets.zero,
                    options: <Segment<PeriodFilter>>[
                      Segment(value: PeriodFilter.today, label: l.auditToday),
                      Segment(value: PeriodFilter.week, label: l.auditWeek),
                    ],
                    selected: filter.period,
                    // Tapping the active chip turns the period filter off.
                    onSelected: (p) => _set(
                      filter.copyWith(
                        period: p == filter.period ? PeriodFilter.any : p,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _Dropdown(
                          key: const Key('audit.user'),
                          label: l.auditUser,
                          anyLabel: l.auditAnyUser,
                          value: filter.userId,
                          options: <String, String>{
                            for (final id in options.users)
                              id: users[id]?.name.of(context) ?? id,
                          },
                          onChanged: (v) => _set(
                            v == null
                                ? filter.copyWith(clearUser: true)
                                : filter.copyWith(userId: v),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _Dropdown(
                          key: const Key('audit.action'),
                          label: l.auditAction,
                          anyLabel: l.auditAnyAction,
                          value: filter.action,
                          options: <String, String>{
                            for (final a in options.actions) a: a,
                          },
                          onChanged: (v) => _set(
                            v == null
                                ? filter.copyWith(clearAction: true)
                                : filter.copyWith(action: v),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    key: const Key('audit.search'),
                    controller: _search,
                    onChanged: (q) => _set(filter.copyWith(query: q)),
                    decoration: InputDecoration(
                      hintText: l.auditSearch,
                      prefixIcon: const Icon(Icons.search_rounded),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l.auditCount(Formats.integer(events.length)),
                    key: const Key('audit.count'),
                    style: context.caption.copyWith(color: c.muted),
                  ),
                  const SizedBox(height: 8),
                  if (events.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        l.auditEmpty,
                        textAlign: TextAlign.center,
                        style: context.body.copyWith(color: c.muted),
                      ),
                    ),
                  for (final (i, e)
                      in events
                          .take(math.min(_shown, events.length))
                          .indexed) ...<Widget>[
                    if (i > 0) const SizedBox(height: 8),
                    _EventCard(
                      key: Key('audit.event.$i'),
                      event: e,
                      users: users,
                    ),
                  ],
                  if (events.length > _shown) ...<Widget>[
                    const SizedBox(height: 12),
                    SecondaryButton(
                      key: const Key('audit.more'),
                      label: l.auditShowMore(
                        Formats.integer(
                          math.min(auditPageSize, events.length - _shown),
                        ),
                      ),
                      onPressed: () => setState(() => _shown += auditPageSize),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}

class _ChainBanner extends StatelessWidget {
  const new({required this.result});

  final ChainResult result;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final locale = Localizations.localeOf(context);
    final (tone, icon, text) = switch (result) {
      ChainOk(:final count, :final head) => (
        StatusTone.ok,
        Icons.verified_user_rounded,
        l.auditChainOk(Formats.integer(count), ltr(shortHash(head))),
      ),
      ChainBroken(:final index, :final event) => (
        StatusTone.bad,
        Icons.gpp_bad_rounded,
        l.auditChainBroken(
          Formats.integer(index + 1),
          ltr(event.action),
          Formats.dateTime(event.ts, locale),
        ),
      ),
    };
    return Container(
      key: Key('audit.chain.${tone.name}'),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tone.background(c),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: tone.foreground(c)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: context.caption.copyWith(
                color: tone.foreground(c),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const new({
    required this.label,
    required this.anyLabel,
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String anyLabel;
  final String? value;
  final Map<String, String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String?>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label, isDense: true),
      items: <DropdownMenuItem<String?>>[
        DropdownMenuItem<String?>(child: Text(anyLabel)),
        for (final MapEntry(:key, :value) in options.entries)
          DropdownMenuItem<String?>(
            value: key,
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class _EventCard extends StatelessWidget {
  const new({required this.event, required this.users, super.key});

  final ActivityEvent event;
  final Map<String, AppUser> users;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final locale = Localizations.localeOf(context);
    final e = event;
    final audit = e.kind == EventKind.audit;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: audit ? c.brandSoft : c.surface2,
                  borderRadius: BorderRadius.circular(AppRadii.tag),
                ),
                child: LtrText(
                  e.action,
                  style: context.mono.copyWith(
                    color: audit ? c.brand : c.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                Formats.dateTime(e.ts, locale),
                style: context.caption.copyWith(color: c.muted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            e.target,
            style: context.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            l.auditMeta(
              users[e.userId]?.name.of(context) ?? e.userId,
              e.role.name,
              e.platform,
              Formats.date(e.ts, locale),
            ),
            style: context.caption.copyWith(color: c.muted),
          ),
          const SizedBox(height: 6),
          if (audit)
            LtrText(
              'prev ${shortHash(e.prevHash)} → ${shortHash(e.hash)}',
              style: context.mono.copyWith(color: c.muted, fontSize: 11),
            )
          else
            Text(
              l.auditUsageNote,
              style: context.micro.copyWith(color: c.muted),
            ),
        ],
      ),
    );
  }
}
