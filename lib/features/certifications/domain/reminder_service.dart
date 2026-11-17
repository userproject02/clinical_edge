import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/features/certifications/domain/certification.dart';

/// One expiry reminder: [cert] at [daysBefore] days before expiry, due at
/// [at] (09:00 Asia/Dubai on that date, as a UTC instant).
class ReminderSlot {
  /// Creates the slot.
  const new({
    required this.id,
    required this.cert,
    required this.daysBefore,
    required this.at,
  });

  /// Notification id (stable for a given certificate list).
  final int id;

  /// The certificate.
  final Certification cert;

  /// 90, 60, 30 or 7.
  final int daysBefore;

  /// When to remind (UTC).
  final DateTime at;
}

/// CERT-4: computes expiry reminders and the certificate to warn about.
///
/// Used by the scheduler (local notifications), the "Simulate expiry
/// reminder" button, the app-bar bell and the Home expiry alert.
class ReminderService {
  /// Creates the service.
  const new({required this.clock});

  /// Time source.
  final Clock clock;

  /// Reminder hour in Dubai local time.
  static const int reminderHourDubai = 9;

  /// Future reminders (90/60/30/7 days before each expiry) for verified,
  /// unexpired certificates, soonest first.
  List<ReminderSlot> upcoming(List<Certification> certs) {
    final now = clock.now().toUtc();
    final slots = <ReminderSlot>[];
    for (final (i, cert) in certs.indexed) {
      if (cert.verification == Verification.pending) continue;
      for (final (j, days) in CertRules.reminderDays.indexed) {
        final date = cert.expiresOn.subtract(Duration(days: days));
        // 09:00 in Dubai (UTC+4, no DST) is 05:00 UTC.
        final at = DateTime.utc(
          date.year,
          date.month,
          date.day,
          reminderHourDubai,
        ).subtract(dubaiOffset);
        if (!at.isAfter(now)) continue;
        slots.add(
          ReminderSlot(
            id: i * CertRules.reminderDays.length + j + 1,
            cert: cert,
            daysBefore: days,
            at: at,
          ),
        );
      }
    }
    return slots..sort((a, b) => a.at.compareTo(b.at));
  }

  /// The certificate to warn about now: the verified one that expires
  /// soonest within the renew-soon window, or null.
  Certification? due(List<Certification> certs) {
    Certification? best;
    for (final c in certs) {
      if (c.status(clock) != CertStatus.renewSoon) continue;
      if (best == null || c.expiresOn.isBefore(best.expiresOn)) best = c;
    }
    return best;
  }

  /// [due], or for a demo with nothing due, the next certificate to
  /// expire (so "Simulate expiry reminder" always has something to show).
  Certification? simulated(List<Certification> certs) {
    final d = due(certs);
    if (d != null) return d;
    final candidates =
        certs
            .where((c) => c.verification == Verification.verified)
            .where((c) => c.daysLeft(clock) > 0)
            .toList()
          ..sort((a, b) => a.expiresOn.compareTo(b.expiresOn));
    return candidates.firstOrNull;
  }
}
