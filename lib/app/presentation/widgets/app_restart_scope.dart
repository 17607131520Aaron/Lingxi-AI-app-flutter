import 'package:flutter/material.dart';

class AppRestartScope extends StatefulWidget {
  const AppRestartScope({super.key, required this.childBuilder});

  final WidgetBuilder childBuilder;

  static void restartApp(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppRestartScopeState>();
    state?.restart();
  }

  @override
  State<AppRestartScope> createState() => _AppRestartScopeState();
}

class _AppRestartScopeState extends State<AppRestartScope> {
  Key appKey = UniqueKey();

  void restart() {
    setState(() {
      appKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: appKey, child: Builder(builder: widget.childBuilder));
  }
}
