import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/core/notifications/local_notifier.dart';
import 'package:clinical_edge/core/persistence/hive_local_db.dart';
import 'package:clinical_edge/features/auth/presentation/session.dart';
import 'package:clinical_edge/features/certifications/data/certificate_file_picker.dart';
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
      db: db,
      prefs: prefs,
      notifier: PluginLocalNotifier(
        channelName: lookupAppLocalizations(const Locale('en')).reminderChannel,
      ),
      filePicker: const PlatformCertificateFilePicker(),
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
