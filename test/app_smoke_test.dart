import 'package:clinical_edge/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TC-PH0-02 placeholder app renders the ClinicalEdge title', (
    tester,
  ) async {
    await tester.pumpWidget(const ClinicalEdgeApp());

    expect(find.text('ClinicalEdge'), findsOneWidget);
  });
}
