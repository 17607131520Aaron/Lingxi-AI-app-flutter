import 'package:flutter/material.dart';
import 'package:lingxi_ai_app/app/app_services.dart';
import 'package:lingxi_ai_app/core/auth/app_role.dart';
import 'package:lingxi_ai_app/features/cart/presentation/pages/cart_page.dart';
import 'package:lingxi_ai_app/features/home/presentation/pages/home_page.dart';
import 'package:lingxi_ai_app/features/product/presentation/pages/product_list_page.dart';
import 'package:lingxi_ai_app/features/profile/presentation/pages/profile_page.dart';
import 'package:lingxi_ai_app/features/role/presentation/pages/role_mine_page.dart';
import 'package:lingxi_ai_app/features/role/presentation/pages/placeholder_role_page.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => MainTabPageState();
}

class MainTabPageState extends State<MainTabPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final config = _buildTabConfig(AppServices.instance.roleStore.readRole());

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: config.pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrangeAccent,
        onTap: (index) {
          if (index == currentIndex) return;
          setState(() {
            currentIndex = index;
          });
        },
        items: config.items,
      ),
    );
  }

  _RoleTabConfig _buildTabConfig(AppRole role) {
    switch (role) {
      case AppRole.normalUser:
        return const _RoleTabConfig(
          pages: [HomePage(), ProductListPage(), CartPage(), ProfilePage()],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: '分类',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: '购物车',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        );
      case AppRole.warehouseKeeper:
        return const _RoleTabConfig(
          pages: [
            PlaceholderRolePage(
              title: '库管首页',
              subtitle: '这里是库管角色首页占位页，后续可接收入库、出库和库存提醒。',
              icon: Icons.warehouse_outlined,
            ),
            PlaceholderRolePage(
              title: '备件管理',
              subtitle: '这里是备件管理占位页，后续可接备件列表、搜索和库存操作。',
              icon: Icons.inventory_2_outlined,
            ),
            RoleMinePage(
              title: '库管个人中心',
              subtitle: '这里是库管角色的个人中心占位页，后续可接账号设置、操作记录和消息。',
              icon: Icons.person_outline,
            ),
          ],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: '备件管理',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        );
      case AppRole.engineer:
        return const _RoleTabConfig(
          pages: [
            PlaceholderRolePage(
              title: '工程师首页',
              subtitle: '这里是工程师角色首页占位页，后续可接工单、任务和告警信息。',
              icon: Icons.engineering_outlined,
            ),
            PlaceholderRolePage(
              title: '工程任务',
              subtitle: '这里是工程任务占位页，后续可接工单列表、处理进度和巡检任务。',
              icon: Icons.build_circle_outlined,
            ),
            RoleMinePage(
              title: '工程师个人中心',
              subtitle: '这里是工程师角色的个人中心占位页，后续可接账号设置、技能标签和通知。',
              icon: Icons.person_outline,
            ),
          ],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build_circle_outlined),
              activeIcon: Icon(Icons.build_circle),
              label: '工程任务',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        );
    }
  }
}

class _RoleTabConfig {
  const _RoleTabConfig({required this.pages, required this.items});

  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;
}
