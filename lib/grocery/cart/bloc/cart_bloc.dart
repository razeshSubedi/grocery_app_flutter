import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/grocery/models/data_model.dart';
import 'package:grocery_app/services/supabase_service.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final String userId;
  CartBloc({required this.userId}) : super(CartInitial()) {
    on<CartInitialEvent>((event, emit) async {
      emit(CartLoadingState());
      final cartProducts = await SupabaseService().fetchCart();
      print("Cart items fetched: ${cartProducts.length}");

      if (cartProducts.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSucessState(cartItems: cartProducts));
      }
    });
    on<CartRemoveItemEvent>((event, emit) async {
      await SupabaseService().removeFromCart(
        event.cartItemToBeDeleted.products.id,
      );

      emit(
        CartItemRemovedState(
          productName: event.cartItemToBeDeleted.products.name,
        ),
      );

      await Future.delayed(Duration(milliseconds: 150));

      final cartProducts = await SupabaseService().fetchCart();
      print("Cart items fetched: ${cartProducts.length}");

      if (cartProducts.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSucessState(cartItems: cartProducts));
      }
    });
    on<CartItemWishlistedEvent>((event, emit) async {
      await SupabaseService().addToWishlist(event.wishlistedItem.id);
      emit(
        CartItemWishlistedState(wishlistedItemName: event.wishlistedItem.name),
      );
    });
  }
}
