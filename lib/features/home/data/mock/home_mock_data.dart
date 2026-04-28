import 'package:flutter/material.dart';
import 'package:lingxi_ai_app/features/home/domain/entities/home_category.dart';
import 'package:lingxi_ai_app/features/home/domain/entities/recommend_product.dart';

class HomeMockData {
  static const List<HomeCategory> categories = [
    HomeCategory('女装', Icons.checkroom),
    HomeCategory('男装', Icons.male),
    HomeCategory('鞋靴', Icons.hiking),
    HomeCategory('箱包', Icons.shopping_bag_outlined),
    HomeCategory('配饰', Icons.watch),
    HomeCategory('美妆', Icons.brush_outlined),
    HomeCategory('家居', Icons.chair_outlined),
    HomeCategory('数码', Icons.phone_android),
    HomeCategory('运动', Icons.sports_soccer),
    HomeCategory('食品', Icons.lunch_dining_outlined),
  ];

  static final List<RecommendProduct> recommendProducts = List.generate(
    30,
    (i) => RecommendProduct(
      title: [
        '时尚连衣裙 夏季新款 修身显瘦 气质裙子',
        '休闲T恤 男短袖纯棉宽松',
        '运动鞋男透气跑步鞋',
        '时尚女包 单肩包斜挎包',
        '无线蓝牙耳机 入耳式降噪',
        '智能手表 运动防水手环',
      ][i % 6],
      price: 89 + (i % 10) * 10,
      originPrice: 129 + (i % 12) * 10,
      sold: 120 + i * 37,
    ),
  );
}
