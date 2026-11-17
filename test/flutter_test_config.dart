import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global test setup (picked up automatically by `flutter test`):
/// * loads the real app fonts and Material Icons so goldens show real text,
/// * uses a golden comparator with a small tolerance (see CLAUDE.md →
///   Decisions: goldens are generated on Linux, the CI platform),
/// * gives every test empty shared preferences.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await _loadFonts();
  if (goldenFileComparator is LocalFileComparator) {
    final base = (goldenFileComparator as LocalFileComparator).basedir;
    goldenFileComparator = _TolerantComparator(
      Uri.parse('${base}flutter_test_config.dart'),
    );
  }
  SharedPreferences.setMockInitialValues(<String, Object>{});
  await testMain();
}

Future<void> _loadFonts() async {
  final manifest = json.decode(
    await rootBundle.loadString('FontManifest.json'),
  ) as List<dynamic>;
  for (final entry in manifest.cast<Map<String, dynamic>>()) {
    final family = entry['family'] as String;
    final loader = FontLoader(
      family.replaceFirst(RegExp('^packages/[^/]+/'), ''),
    );
    for (final font
        in (entry['fonts'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}

/// Accepts goldens that differ by at most 0.5 % of pixels (anti-aliasing
/// noise between machines), and fails on anything larger.
class _TolerantComparator extends LocalFileComparator {
  new(super.testFile);

  static const double _tolerance = 0.005;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );
    if (result.passed || result.diffPercent <= _tolerance) {
      result.dispose();
      return true;
    }
    final error = await generateFailureOutput(result, golden, basedir);
    result.dispose();
    throw TestFailure(error);
  }
}
