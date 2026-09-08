import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_cicd_lab/main.dart';

void main() {
  testWidgets('Counter increments when button is pressed',
      (WidgetTester tester) async {

    await tester.pumpWidget(const MyApp());

    expect(find.text('Counter: 0'), findsOneWidget);

    await tester.tap(find.text('Increment'));
    await tester.pump();

    expect(find.text('Counter: 1'), findsOneWidget);
  });
}
