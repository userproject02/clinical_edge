import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/logging/activity_event.dart';

/// Kind filter on the audit log.
enum KindFilter {
  /// Audit and usage.
  all,

  /// Audit trail only.
  audit,

  /// Usage analytics only.
  usage,
}

/// Period filter on the audit log.
enum PeriodFilter {
  /// No time limit.
  any,

  /// Today (Dubai calendar day).
  today,

  /// The last 7 days including today.
  week,
}

/// Combined audit-log filters (ADM-2). All filters combine with AND.
class AuditFilter {
  /// Creates the filter.
  const new({
    this.kind = KindFilter.all,
    this.period = PeriodFilter.any,
    this.userId,
    this.action,
    this.query = '',
  });

  /// Kind.
  final KindFilter kind;

  /// Period.
  final PeriodFilter period;

  /// User id, or null for everyone.
  final String? userId;

  /// Action wire name, or null for every action.
  final String? action;

  /// Case-insensitive search on the target text.
  final String query;

  /// Copy with changes (pass `clearUser` / `clearAction` to reset those).
  AuditFilter copyWith({
    KindFilter? kind,
    PeriodFilter? period,
    String? userId,
    String? action,
    String? query,
    bool clearUser = false,
    bool clearAction = false,
  }) => AuditFilter(
    kind: kind ?? this.kind,
    period: period ?? this.period,
    userId: clearUser ? null : userId ?? this.userId,
    action: clearAction ? null : action ?? this.action,
    query: query ?? this.query,
  );

  /// Applies the filter to [events] (any order) and returns them newest
  /// first.
  List<ActivityEvent> apply(List<ActivityEvent> events, Clock clock) {
    final today = clock.today();
    final from = switch (period) {
      PeriodFilter.any => null,
      PeriodFilter.today => today,
      PeriodFilter.week => today.subtract(const Duration(days: 6)),
    };
    final q = query.trim().toLowerCase();
    return events.where((e) {
      if (kind == KindFilter.audit && e.kind != EventKind.audit) return false;
      if (kind == KindFilter.usage && e.kind != EventKind.usage) return false;
      if (from != null && dubaiDate(e.ts).isBefore(from)) return false;
      if (userId != null && e.userId != userId) return false;
      if (action != null && e.action != action) return false;
      if (q.isNotEmpty && !e.target.toLowerCase().contains(q)) return false;
      return true;
    }).toList()..sort((a, b) => b.ts.compareTo(a.ts));
  }
}

/// CSV of [events] (ADM-3): header plus one row per event, RFC 4180
/// quoting (fields with comma, quote, CR or LF are quoted; quotes doubled),
/// CRLF line endings.
String auditCsv(List<ActivityEvent> events) {
  String cell(String? v) {
    final s = v ?? '';
    return RegExp('[",\r\n]').hasMatch(s) ? '"${s.replaceAll('"', '""')}"' : s;
  }

  final rows = <List<String?>>[
    [
      'ts',
      'user',
      'role',
      'action',
      'target',
      'platform',
      'kind',
      'prevHash',
      'hash',
    ],
    for (final e in events)
      [
        e.ts.toUtc().toIso8601String(),
        e.userId,
        e.role.name,
        e.action,
        e.target,
        e.platform,
        e.kind.name,
        e.prevHash,
        e.hash,
      ],
  ];
  return '${rows.map((r) => r.map(cell).join(',')).join('\r\n')}\r\n';
}
