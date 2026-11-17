import 'package:clinical_edge/core/widgets/app_scaffold.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/golden.dart';
import '../../helpers/test_app.dart';

void main() {
  group('AppScaffold', () {
    testWidgets('TC-PH1-10 tab bar shows subtitle, title, bell and avatar', (
      tester,
    ) async {
      var bell = 0;
      var avatar = 0;
      await pumpTestApp(
        tester,
        AppScaffold.tab(
          subtitle: 'Demo Health Network · Dubai',
          title: 'Courses',
          hasUnread: true,
          onBellPressed: () => bell++,
          avatarInitials: 'LH',
          onAvatarPressed: () => avatar++,
          body: const SizedBox(),
        ),
      );
      expect(find.text('Demo Health Network · Dubai'), findsOneWidget);
      expect(find.text('Courses'), findsOneWidget);
      await tester.tap(find.byTooltip('Notifications'));
      await tester.tap(find.bySemanticsLabel('Profile and settings'));
      expect((bell, avatar), (1, 1));
    });

    testWidgets('TC-PH1-11 detail back arrow mirrors in RTL and pops', (
      tester,
    ) async {
      var backs = 0;
      Widget screen() => AppScaffold.detail(
        title: 'Checkout',
        onBack: () => backs++,
        body: const SizedBox(),
      );

      await pumpTestApp(tester, screen());
      final ltrArrow = tester.getRect(find.byIcon(Icons.arrow_back_rounded));
      expect(Icons.arrow_back_rounded.matchTextDirection, isTrue);
      expect(ltrArrow.left, lessThan(195), reason: 'start edge in LTR');

      await pumpTestApp(tester, screen(), variant: Variant.lightRtl);
      await tester.pumpAndSettle();
      final rtlArrow = tester.getRect(find.byIcon(Icons.arrow_back_rounded));
      expect(rtlArrow.left, greaterThan(195), reason: 'start edge in RTL');
      final icon = tester.element(find.byIcon(Icons.arrow_back_rounded));
      expect(Directionality.of(icon), TextDirection.rtl);

      await tester.tap(find.byTooltip('رجوع'));
      expect(backs, 1);
    });

    testWidgets('TC-PH1-12 detail bar takes a custom colour', (tester) async {
      await pumpTestApp(
        tester,
        const AppScaffold.detail(
          title: 'Lesson',
          barColor: Color(0xFF07393C),
          barForeground: Color(0xFFE8F4F4),
          body: SizedBox(),
        ),
      );
      final box = tester.widget<ColoredBox>(
        find
            .ancestor(
              of: find.text('Lesson'),
              matching: find.byType(ColoredBox),
            )
            .first,
      );
      expect(box.color, const Color(0xFF07393C));
    });
  });

  goldenVariants(
    'app_scaffold_tab',
    () => SizedBox(
      height: 120,
      child: AppScaffold.tab(
        subtitle: 'Demo Health Network · Dubai',
        title: 'Certifications & CPD',
        hasUnread: true,
        onBellPressed: () {},
        avatarInitials: 'LH',
        onAvatarPressed: () {},
        body: const SizedBox(),
      ),
    ),
    size: const Size(390, 160),
  );

  goldenVariants(
    'app_scaffold_detail',
    () => const SizedBox(
      height: 72,
      child: AppScaffold.detail(
        title: 'Basic Life Support Refresher',
        barColor: Color(0xFF07393C),
        barForeground: Color(0xFFE8F4F4),
        body: SizedBox(),
      ),
    ),
    size: const Size(390, 104),
  );
}
