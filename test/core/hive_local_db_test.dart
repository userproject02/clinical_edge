import 'dart:io';

import 'package:clinical_edge/core/logging/audit_chain.dart';
import 'package:clinical_edge/core/logging/stores.dart';
import 'package:clinical_edge/core/persistence/hive_local_db.dart';
import 'package:clinical_edge/core/persistence/local_db.dart';
import 'package:clinical_edge/seed/demo_seeder.dart';
import 'package:clinical_edge/seed/seed_loader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'TC-PH2-07 Hive store persists across reopen and clears on reset',
    () async {
      final dir = await Directory.systemTemp.createTemp('ce_hive');
      addTearDown(() => dir.delete(recursive: true));

      var db = HiveLocalDb.atPath(dir.path);
      final seeder = DemoSeeder(
        db: db,
        seed: AssetSeedLoader(),
        auditStore: LocalAuditStore(db),
      );
      await seeder.ready;
      final progress = await db.open(Collections.progress);
      expect(await progress.count(), 6);
      await progress.put('u-layla|c1-l5', <String, Object?>{
        'lessonId': 'c1-l5',
      });
      await db.close();

      db = HiveLocalDb.atPath(dir.path);
      expect(await (await db.open(Collections.progress)).count(), 7);
      final audit = await LocalAuditStore(db).list();
      expect(audit, hasLength(10));
      expect(AuditChain.verify(audit), isA<ChainOk>());

      await db.clearAll();
      expect(await (await db.open(Collections.audit)).count(), 0);
      await db.close();
    },
  );
}
