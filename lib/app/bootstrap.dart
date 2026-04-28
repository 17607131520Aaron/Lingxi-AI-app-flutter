import 'package:flutter/widgets.dart';

import 'app.dart';
import 'app_services.dart';

/// App 启动入口：用于承载企业级初始化逻辑。
///
/// 后续可在此加入：
/// - 环境配置加载（dev/staging/prod）
/// - 依赖注入装配（DI）
/// - 日志/崩溃收集（Crash reporting）
/// - 本地存储初始化
Future<Widget> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppServices.instance.init();

  return const LinggoMallApp();
}
