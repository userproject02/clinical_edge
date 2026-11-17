import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/app_bottom_sheet.dart';
import 'package:clinical_edge/core/widgets/app_snack_bar.dart';
import 'package:clinical_edge/core/widgets/notification_banner.dart';
import 'package:clinical_edge/core/widgets/status_tag.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

void main() {
  testWidgets('TC-PH1-28 snackbar slides up, stays, then leaves', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => AppSnackBar.show(
            context,
            title: 'Certificate uploaded',
            message: 'NRP is pending verification',
            tone: StatusTone.blue,
          ),
          child: const Text('go'),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final mid = tester.getRect(find.byType(AppSnackBar));
    await tester.pump(Motion.snackbar);
    final end = tester.getRect(find.byType(AppSnackBar));
    expect(mid.top, greaterThan(end.top), reason: 'moves up while entering');
    expect(find.text('Certificate uploaded'), findsOneWidget);
    await tester.pump(Motion.snackbarVisible + Motion.snackbar * 2);
    await tester.pumpAndSettle();
    expect(find.byType(AppSnackBar), findsNothing);
  });

  testWidgets('TC-PH1-29 banner drops in from the top and auto-dismisses', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      Builder(
        builder: (context) => Center(
          child: TextButton(
            onPressed: () => NotificationBanner.show(
              context,
              title: 'BLS expires in 56 days',
              message: 'Renew by 12 Jan 2027',
            ),
            child: const Text('go'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    final mid = tester.getRect(find.byType(NotificationBanner));
    await tester.pump(Motion.banner);
    final end = tester.getRect(find.byType(NotificationBanner));
    expect(mid.top, lessThan(end.top), reason: 'moves down while entering');
    expect(find.text('CLINICALEDGE'), findsOneWidget);
    await tester.pump(Motion.bannerVisible + Motion.banner * 2);
    await tester.pumpAndSettle();
    expect(find.byType(NotificationBanner), findsNothing);
  });

  testWidgets('TC-PH1-30 bottom sheet opens over a scrim and closes', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      Builder(
        builder: (context) => Center(
          child: TextButton(
            onPressed: () => showAppBottomSheet<void>(
              context: context,
              builder: (_) => const AppBottomSheet(
                title: 'Upload certificate',
                child: Text('body'),
              ),
            ),
            child: const Text('go'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Upload certificate'), findsOneWidget);
    await tester.pumpAndSettle();
    final sheet = tester.getRect(find.byType(AppBottomSheet));
    expect(sheet.bottom, 844);
    await tester.tapAt(const Offset(195, 40));
    await tester.pumpAndSettle();
    expect(find.byType(AppBottomSheet), findsNothing);
  });

  goldenVariants(
    'app_snack_bar',
    () => const AppSnackBar(
      title: 'Sign-off requested',
      message: 'Dr. Omar Al Mansoori will review it',
    ),
    size: const Size(390, 100),
  );

  goldenVariants(
    'notification_banner',
    () => const NotificationBanner(
      title: 'BLS Provider expires in 56 days',
      message: 'Renew before 12 Jan 2027 to stay compliant.',
    ),
    size: const Size(390, 130),
  );

  goldenVariants(
    'app_bottom_sheet',
    () => const AppBottomSheet(
      title: 'Upload certificate',
      child: Text('Scan with camera or choose a file.'),
    ),
    size: const Size(390, 180),
  );
}
