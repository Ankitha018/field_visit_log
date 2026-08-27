import 'package:flutter_test/flutter_test.dart';

import 'package:field_visit_log/app/app.dart';

void main() {
  testWidgets(
    'Field Visit app loads',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const FieldVisitApp(),
      );

      await tester.pump();

      expect(
        find.text('Field Visits'),
        findsOneWidget,
      );
    },
  );
}