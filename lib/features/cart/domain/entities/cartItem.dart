class CartItem {
  CartItem({
    required this.title,
    required this.sku,
    required this.price,
    required this.originPrice,
    required this.count,
    this.selected = false,
    String? id,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();

  final String id;
  final String title;
  final String sku;
  final int price;
  final int originPrice;
  int count;
  bool selected;
}

