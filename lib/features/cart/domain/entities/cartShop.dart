import 'package:lingxi_ai_app/features/cart/domain/entities/cartItem.dart';

class CartShop {
  CartShop({required this.shopName, required this.items});

  final String shopName;
  final List<CartItem> items;
}
