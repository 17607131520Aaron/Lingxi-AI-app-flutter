import 'package:flutter/material.dart';
import 'package:lingxi_ai_app/features/role/presentation/widgets/role_switcher_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),

              // 顶部用户信息卡片（参考截图的粉色背景）
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFFF7D7D), Color(0xFFFF9E9E)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Color(0xFFFF7D7D), size: 32),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '用户昵称',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'ID: user123',
                                style: TextStyle(fontSize: 13, color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 我的订单 + 4 个状态入口
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '我的订单',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('查看全部 >', style: TextStyle(fontSize: 13, color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: const [
                          OrderStatusItem(
                            icon: Icons.payments_outlined,
                            label: '待付款',
                            badgeCount: 2,
                          ),
                          OrderStatusItem(
                            icon: Icons.inventory_2_outlined,
                            label: '待发货',
                            badgeCount: 1,
                          ),
                          OrderStatusItem(
                            icon: Icons.local_shipping_outlined,
                            label: '待收货',
                            badgeCount: 3,
                          ),
                          OrderStatusItem(
                            icon: Icons.rate_review_outlined,
                            label: '待评价',
                            badgeCount: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const RoleSwitcherCard(),
              ),

              const SizedBox(height: 12),

              // 下方功能列表
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    buildProfileItem(context, icon: Icons.place_outlined, title: '收货地址'),
                    const Divider(height: 1),
                    buildProfileItem(context, icon: Icons.card_giftcard_outlined, title: '优惠券'),
                    const Divider(height: 1),
                    buildProfileItem(context, icon: Icons.star_border, title: '我的收藏'),
                    const Divider(height: 1),
                    buildProfileItem(context, icon: Icons.visibility_outlined, title: '浏览记录'),
                    const Divider(height: 1),
                    buildProfileItem(context, icon: Icons.support_agent_outlined, title: '联系客服'),
                    const Divider(height: 1),
                    buildProfileItem(context, icon: Icons.settings_outlined, title: '设置'),
                    const Divider(height: 1),
                    buildProfileItem(context, icon: Icons.notifications_none, title: '消息通知'),
                    const Divider(height: 1),
                    buildProfileItem(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      title: '我的钱包',
                      isLast: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title 功能暂未实现（示例）')));
      },
    );
  }
}

class OrderStatusItem extends StatelessWidget {
  const OrderStatusItem({
    super.key,
    required this.icon,
    required this.label,
    required this.badgeCount,
  });

  final IconData icon;
  final String label;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(icon, color: const Color(0xFFFF7D7D)),
              ),
              if (badgeCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$badgeCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}
