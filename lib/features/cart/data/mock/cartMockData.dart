import 'package:lingxi_ai_app/features/cart/domain/entities/cartItem.dart';
import 'package:lingxi_ai_app/features/cart/domain/entities/cartShop.dart';

class CartMockData {
  // 淘宝购物车常见：按店铺分组
  static List<CartShop> initialShops() {
    return [
      CartShop(
        shopName: 'Linggo 官方旗舰店',
        items: [
          CartItem(
            title: '无线蓝牙耳机 入耳式降噪',
            sku: '黑色｜标准版',
            price: 129,
            originPrice: 199,
            count: 1,
            id: 'shop1_item1',
          ),
          CartItem(
            title: '智能手表 运动防水手环',
            sku: '银色｜NFC',
            price: 239,
            originPrice: 299,
            count: 2,
            id: 'shop1_item2',
          ),
        ],
      ),
      CartShop(
        shopName: '精选生活馆',
        items: [
          CartItem(
            title: '时尚连衣裙 夏季新款 修身显瘦',
            sku: 'S｜粉色',
            price: 199,
            originPrice: 269,
            count: 1,
            id: 'shop2_item1',
          ),
          CartItem(
            title: '运动鞋男透气跑步鞋 轻便耐磨',
            sku: '42｜白黑',
            price: 259,
            originPrice: 329,
            count: 1,
            id: 'shop2_item2',
          ),
          CartItem(
            title: '时尚女包 单肩包斜挎包',
            sku: '米白｜小号',
            price: 159,
            originPrice: 239,
            count: 1,
            id: 'shop2_item3',
          ),
        ],
      ),
    ];
  }
}
