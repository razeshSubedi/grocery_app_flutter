import 'package:bloc/bloc.dart';
import 'package:grocery_app/data/cart_items.dart';
import 'package:grocery_app/data/wishlist_items.dart';
import 'package:grocery_app/grocery/models/data_model.dart';

import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(
      (event, emit) async {
        emit(CartLoadingState());
        await Future.delayed(Duration(seconds: 1));
        if (cartItems.isEmpty) {
          emit(CartEmptyState());
        } else {
          emit(CartSucessState(cartItems: cartItems));
        }
      },
    );
    on<CartRemoveItemEvent>(
      (event, emit) {
        cartItems.remove(event.cartItemToBeDeleted);
        emit(CartItemRemovedState(productName: event.cartItemToBeDeleted.name));
        emit(CartSucessState(cartItems: cartItems));
        if (cartItems.isEmpty) {
          emit(CartEmptyState());
        }
      },
    );
  on<CartItemWishlistedEvent>((event, emit) {
    wishlistItems.add(event.wishlistedItem);
    emit(CartItemWishlistedState(wishlistedItemName: event.wishlistedItem.name));
  },);
    
  }
}
