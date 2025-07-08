import 'dart:ui';

import 'package:grocery_app/grocery/models/data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<List<ProductsDataModel>> fetchAllProducts() async {
    final data = await supabase.from('products').select();

    return (data as List)
        .map(
          (e) => ProductsDataModel(
            id: e['id'],
            name: e['name'],
            imageUrl: e['image_url'],
            price: (e['price'] as num).toDouble(),
            category: e['category'],
            unit: e['unit'],
          ),
        )
        .toList();
  }

  // current user ID
  String? getCurrentUserId() {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    print(userId);
    return userId;
  }

  Future<void> addToWishlist(int productId) async {
    final userId = getCurrentUserId();
    await supabase.from('wishlist').insert({
      'user_id': userId,
      'product_id': productId,
    });
  }

  Future<void> removeFromWishlist(int productId) async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("user is not logged in");
    }
    await supabase.from('wishlist').delete().match({
      'user_id': userId,
      'product_id': productId,
    });
  }

  Future<void> addToCart(int productId, {int quantity = 1}) async {
    final userId = getCurrentUserId();
    await supabase.from('cart').upsert({
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
    });
  }

  Future<void> removeFromCart(int productId) async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("user is not logged in");
    }
    await supabase.from('cart').delete().match({
      'user_id': userId,
      'product_id': productId,
    });
  }

  Future<List<ProductsDataModel>> fetchWishlist() async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("user is not logged in");
    }
    final data = await supabase
        .from('wishlist')
        .select('product_id, products(*)')
        .eq('user_id', userId);

    return (data as List)
        .map(
          (e) => ProductsDataModel(
            id: e['products']['id'],
            name: e['products']['name'],
            unit: e['products']['unit'],
            imageUrl: e['products']['image_url'],
            price: (e['products']['price'] as num).toDouble(),
            category: e['products']['category'],
          ),
        )
        .toList();
  }

  Future<List<CartItemModel>> fetchCart() async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("user is not logged in");
    }
    final data = await supabase
        .from('cart')
        .select('quantity, products(*)')
        .eq('user_id', userId)
        .order('added_at');

    return (data as List)
        .map(
          (e) => CartItemModel(
            products: ProductsDataModel(
              unit: e['products']['unit'],
              id: e['products']['id'],
              name: e['products']['name'],
              imageUrl: e['products']['image_url'],
              price: (e['products']['price'] as num).toDouble(),
              category: e['products']['category'],
            ),
            quantity: e['quantity'],
          ),
        )
        .toList();
  }

  void listenToProductChanges(VoidCallback onChange) {
    final channel = Supabase.instance.client.channel('products_changes');

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'products',
          callback: (payload) {
            print("Product table change detected: ${payload.toString()}");
            onChange(); //refresh UI
          },
        )
        .subscribe();
  }

  Future<void> updateCartQuantity({
    required int productId,
    required int quantity,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.id;
    try {
      await supabase.from('cart').update({'quantity': quantity}).match({
        'user_id': userId,
        'product_id': productId,
      });
    } catch (e) {
      throw Exception('Failed to update cart: error ${e.toString()}');
    }
  }
}
