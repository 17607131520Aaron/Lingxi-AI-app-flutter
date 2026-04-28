import 'package:flutter/material.dart';
import 'package:lingxi_ai_app/app/app_services.dart';
import 'package:lingxi_ai_app/app/presentation/widgets/app_restart_scope.dart';
import 'package:lingxi_ai_app/app/router/app_router.dart';
import 'package:lingxi_ai_app/app/router/app_routes.dart';
import 'package:lingxi_ai_app/core/auth/app_role.dart';

class RoleSwitcherCard extends StatefulWidget {
  const RoleSwitcherCard({super.key});

  @override
  State<RoleSwitcherCard> createState() => _RoleSwitcherCardState();
}

class _RoleSwitcherCardState extends State<RoleSwitcherCard> {
  late AppRole currentRole;

  @override
  void initState() {
    super.initState();
    currentRole = AppServices.instance.roleStore.readRole();
  }

  Future<void> onRoleChanged(AppRole? role) async {
    if (role == null || role == currentRole) return;

    await AppServices.instance.roleStore.saveRole(role);
    if (!mounted) return;

    setState(() {
      currentRole = role;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('已切换为${role.label}，应用正在重启')));

    AppRouter.initialRoute = AppRoutes.home;
    AppRestartScope.restartApp(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('角色切换', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButtonFormField<AppRole>(
            initialValue: currentRole,
            decoration: InputDecoration(
              labelText: '当前角色',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: const Icon(Icons.manage_accounts_outlined),
            ),
            items: AppRole.values.map((role) {
              return DropdownMenuItem<AppRole>(
                value: role,
                child: Text(role.label),
              );
            }).toList(),
            onChanged: onRoleChanged,
          ),
          const SizedBox(height: 8),
          Text(
            '切换角色后会自动重启应用，并加载该角色对应的底部 Tab。',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
