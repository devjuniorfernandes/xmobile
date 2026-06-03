import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_mobile/main.dart';

void main() {
  testWidgets('renders x mobile app', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: XMobileApp()));

    expect(find.text('X mobile'), findsOneWidget);
  });
}
