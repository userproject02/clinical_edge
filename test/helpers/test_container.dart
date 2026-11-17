import 'package:clinical_edge/app/mock_overrides.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A [ProviderContainer] wired exactly like `main.dart`, but on an
/// in-memory database ([db] to share one across "restarts").
Future<ProviderContainer> mockContainer({
  InMemoryLocalDb? db,
  Map<String, Object> prefs = const <String, Object>{},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final container = ProviderContainer(
    overrides: mockOverrides(
      db: db ?? InMemoryLocalDb(),
      prefs: await SharedPreferences.getInstance(),
    ),
  );
  addTearDown(container.dispose);
  return container;
}
