class ProductsDataModel {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;

  ProductsDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
  });
}

class CartItemModel {
  final ProductsDataModel products;
  final int quantity;

  CartItemModel({required this.products, required this.quantity});
}
