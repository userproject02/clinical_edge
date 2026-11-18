import 'dart:math';

import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/core/notifications/local_notifier.dart';
import 'package:clinical_edge/core/persistence/hive_local_db.dart';
import 'package:clinical_edge/core/persistence/latency_local_db.dart';
import 'package:clinical_edge/core/sharing/file_sharer.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/data/certificate_file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final db = await HiveLocalDb.init();
  // v1: every data source is a mock (AGENTS.md → Architecture rules).
  final container = ProviderContainer(
    overrides: mockOverrides(
      // 300–900 ms on list queries so loading states show (NFR).
      db: LatencyLocalDb(db, random: Random()),
      prefs: prefs,
      // Web preview: no native notifications or picker; mocks stay in place.
      notifier: kIsWeb
          ? null
          : PluginLocalNotifier(
              channelName: lookupAppLocalizations(const Locale('en'))
                  .reminderChannel,
            ),
      filePicker: kIsWeb ? null : const PlatformCertificateFilePicker(),
      sharer: const PluginFileSharer(),
    ),
  );
  // Restore the stored session before the first frame, so a restart lands
  // on the right home without flashing the sign-in screen.
  await container.read(sessionProvider.future);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ClinicalEdgeApp(),
    ),
  );
}
