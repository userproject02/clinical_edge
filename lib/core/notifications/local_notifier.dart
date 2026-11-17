import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

part 'local_notifier.g.dart';

/// One local notification to show at [at] (UTC instant).
class ScheduledNotification {
  /// Creates the notification.
  const new({
    required this.id,
    required this.at,
    required this.title,
    required this.body,
  });

  /// Stable id (re-scheduling replaces it).
  final int id;

  /// When to show it (UTC).
  final DateTime at;

  /// Bold line.
  final String title;

  /// Body.
  final String body;

  @override
  String toString() => 'ScheduledNotification($id, $at, $title)';
}

/// Device local notifications (CERT-4). v1 delivers expiry reminders only.
abstract interface class LocalNotifier {
  /// Asks the OS for permission; true when granted.
  Future<bool> requestPermission();

  /// Shows a notification now (no-op if the OS denies it).
  Future<void> showNow({required String title, required String body});

  /// Replaces every scheduled notification with [items].
  Future<void> replaceSchedule(List<ScheduledNotification> items);
}

/// Android channel for expiry reminders.
const String expiryChannelId = 'expiry_reminders';

/// [LocalNotifier] on `flutter_local_notifications` (iOS + Android).
class PluginLocalNotifier implements LocalNotifier {
  /// Creates the notifier; [channelName] is the user-visible channel name.
  new({required this.channelName, FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  /// Android channel name ("Expiry reminders").
  final String channelName;

  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _init;

  /// Id used by [showNow] (scheduled ids stay below it).
  static const int immediateId = 999999;

  Future<void> _ready() => _init ??= _plugin
      .initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          // Permission is requested explicitly on first enable.
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
      )
      .then((_) {});

  NotificationDetails get _details => NotificationDetails(
    android: AndroidNotificationDetails(
      expiryChannelId,
      channelName,
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: const DarwinNotificationDetails(
      presentAlert: true,
      presentBanner: true,
      presentList: true,
      presentSound: true,
    ),
  );

  @override
  Future<bool> requestPermission() async {
    await _ready();
    if (Platform.isIOS) {
      return await _plugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    return await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission() ??
        false;
  }

  @override
  Future<void> showNow({required String title, required String body}) async {
    await _ready();
    await _plugin.show(
      id: immediateId,
      title: title,
      body: body,
      notificationDetails: _details,
    );
  }

  @override
  Future<void> replaceSchedule(List<ScheduledNotification> items) async {
    await _ready();
    await _plugin.cancelAllPendingNotifications();
    for (final n in items) {
      await _plugin.zonedSchedule(
        id: n.id,
        title: n.title,
        body: n.body,
        scheduledDate: tz.TZDateTime.from(n.at, tz.UTC),
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }
}

/// In-memory [LocalNotifier] for tests and previews: records every call.
class RecordingLocalNotifier implements LocalNotifier {
  /// Whether [requestPermission] grants.
  bool grant = true;

  /// Permission requests made.
  int permissionRequests = 0;

  /// Notifications shown with [showNow].
  final List<({String title, String body})> shown = [];

  /// Current schedule.
  List<ScheduledNotification> scheduled = const [];

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return grant;
  }

  @override
  Future<void> showNow({required String title, required String body}) async {
    shown.add((title: title, body: body));
  }

  @override
  Future<void> replaceSchedule(List<ScheduledNotification> items) async {
    scheduled = List.unmodifiable(items);
  }
}

/// The device notifier (overridden in `main.dart` and tests).
@Riverpod(keepAlive: true)
LocalNotifier localNotifications(Ref ref) =>
    throw UnimplementedError('Override localNotificationsProvider.');
