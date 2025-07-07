import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/grocery/models/data_model.dart';
import 'package:grocery_app/services/supabase_service.dart';

part 'home_event.dart';
part 'home_state.dart';

List<ProductsDataModel> _allProducts = [];

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String userId;
  HomeBloc({required this.userId}) : super(HomeInitial()) {
    on<HomeInitialFetchEvent>((event, emit) async {
      emit(HomeLoadingState());
      final products = await SupabaseService().fetchAllProducts();
      _allProducts = products;
      emit(HomeLoadingSucessState(products: products));
    });

    on<WishlistButtonClicked>((event, emit) async {
      await SupabaseService().addToWishlist(event.clickedWishlistItem.id);

      emit(ProductAddedToWishlistState(message: "Product is saved. "));
    });

    on<CartButtonClicked>((event, emit) async {
      print("product added");

      await SupabaseService().addToCart(event.clickedCartItem.id);
      emit(ProductAddedToCartState(message: "Product is added to the cart."));
    });
    on<HomeSearchEvent>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = _allProducts
          .where((p) => p.name.toLowerCase().contains(query))
          .toList();
      emit(HomeLoadingSucessState(products: filtered));
    });
  }
}
