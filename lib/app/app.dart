import 'package:flutter/material.dart';

import '../core/auth/app_role.dart';
import '../core/feedback/app_messenger.dart';
import 'presentation/widgets/app_restart_scope.dart';
import 'router/app_router.dart';

class LinggoMallApp extends StatelessWidget {
  const LinggoMallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRestartScope(
      childBuilder: (context) {
        return MaterialApp(
          // title: 'Linggo AI Mall',
          scaffoldMessengerKey: AppMessenger.scaffoldMessengerKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: _seedColorForRole(AppRouter.currentRole),
            ),
            useMaterial3: true,
          ),
          initialRoute: AppRouter.initialRoute,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }

  Color _seedColorForRole(AppRole role) {
    switch (role) {
      case AppRole.normalUser:
        return Colors.deepPurple;
      case AppRole.warehouseKeeper:
        return Colors.teal;
      case AppRole.engineer:
        return Colors.indigo;
    }
  }
}
