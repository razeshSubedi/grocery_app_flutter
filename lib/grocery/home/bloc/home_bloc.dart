import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/cart_items.dart';
import 'package:grocery_app/data/grocery_data.dart';
import 'package:grocery_app/data/wishlist_items.dart';
import 'package:grocery_app/grocery/models/data_model.dart';



part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        await Future.delayed(Duration(seconds: 1));
        emit(
          HomeLoadingSucessState(
            products: GroceryData.groceryProducts
                .map(
                  (e) => ProductsDataModel(
                    id: e["id"],
                    name: e["name"],
                    imageUrl: e["imageUrl"],
                    price: e["price"],
                    category: e["category"],
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    on<WishlistNavigationButtonClicked>((event, emit) {
      emit(NavigateToWishlistPageState());
    });
    on<CartNavigationButtonClicked>((event, emit) {
      emit(NavigateToCartPageState());
    });

    on<WishlistButtonClicked>((event, emit) {
      print(wishlistItems.length);
      wishlistItems.add(event.clickedWishlistItem);
      print(wishlistItems.length);
      emit(ProductAddedToWishlistState(message: "Product is wishlisted. "));
    },);

    on<CartButtonClicked>((event, emit) {

     cartItems.add(event.clickedCartItem);
     emit(ProductAddedToCartState(message: "Product is added to the cart."));
    },);
  }
}
