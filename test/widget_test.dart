import 'package:flutter_test/flutter_test.dart';
import 'package:lingxi_ai_app/app/app.dart';
import 'package:lingxi_ai_app/app/app_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('app shows login page on startup', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await AppServices.instance.init();

    await tester.pumpWidget(const LinggoMallApp());
    await tester.pumpAndSettle();

    expect(find.text('Linggo AI Mall'), findsOneWidget);
    expect(find.text('登录'), findsOneWidget);
  });
}
