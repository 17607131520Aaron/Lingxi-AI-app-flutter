import 'package:flutter/material.dart';

import 'package:lingxi_ai_app/features/product/data/mock/productCategoryMock.dart';

/// 分类页（参考你提供的左侧分类 + 右侧网格的设计）
class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  final List<String> categories = ProductCategoryMock.categories;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String currentCategory = categories[selectedIndex];
    final subList = ProductCategoryMock.getSubCategories(currentCategory);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            // 左侧分类导航
            Container(
              width: 80,
              color: const Color(0xFFF7F7F7),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final selected = index == selectedIndex;
                  final text = categories[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: selected ? Colors.white : Colors.transparent,
                        border: Border(
                          left: BorderSide(
                            color:
                                selected ? Colors.redAccent : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 14,
                          color: selected ? Colors.redAccent : Colors.black87,
                          fontWeight:
                              selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 右侧子分类网格
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: subList.length,
                  itemBuilder: (context, index) {
                    final name = subList[index];
                    return GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('点击了 $name')),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '图',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
