import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    this.productId,
  });

  final String? productId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('商品详情'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: theme.colorScheme.primaryContainer,
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'AI 商品详情',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '商品 ID: ${productId ?? '（未传入）'}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '这里是商品的详细描述区域，后续可以接入后端接口，展示真实的商品信息、价格、库存等内容。',
              style: theme.textTheme.bodyMedium,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  // TODO: 后续接入购物车逻辑
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已加入购物车（示例）')),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('加入购物车'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

