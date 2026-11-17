import 'package:clinical_edge/app/app.dart';
import 'package:clinical_edge/app/state/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      // Mock implementations are chosen here (Firebase later, AGENTS.md).
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const ClinicalEdgeApp(),
    ),
  );
}
