class ProductsDataModel {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final String unit;

  ProductsDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.unit,
  });
}

class CartItemModel {
  final ProductsDataModel products;
  final int quantity;

  CartItemModel({required this.products, required this.quantity});
}
