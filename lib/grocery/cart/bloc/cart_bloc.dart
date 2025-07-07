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
      print("trying to fetch");
      final cartProducts = await SupabaseService().fetchCart();

      print("Cart items fetched: ${cartProducts.length}");
      double totalPrice = 0;
      for (var item in cartProducts) {
        totalPrice += item.quantity * item.products.price;
      }
      if (cartProducts.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSucessState(cartItems: cartProducts, totalPrice: totalPrice));
      }

      if (cartProducts.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSucessState(cartItems: cartProducts, totalPrice: totalPrice));
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

      double totalPrice = 0;
      final cartProducts = await SupabaseService().fetchCart();
      print("Cart items fetched: ${cartProducts.length}");
      for (var item in cartProducts) {
        totalPrice += item.quantity * item.products.price;
      }
      if (cartProducts.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSucessState(cartItems: cartProducts, totalPrice: totalPrice));
      }
    });

    on<CartQuantityChangedEvent>((event, emit) async {
      SupabaseService().updateCartQuantity(
        productId: event.productId,
        quantity: event.updatedQuantity,
      );
      
      double totalPrice = 0;
      final cartProducts = await SupabaseService().fetchCart();
      print("Cart items fetched: ${cartProducts.length}");
      for (var item in cartProducts) {
        totalPrice += item.quantity * item.products.price;
      }

      emit(CartSucessState(cartItems: cartProducts, totalPrice: totalPrice));
    });
  }
}
