part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartSucessState extends CartState {
  final List<CartItemModel> cartItems;
  final double totalPrice;

  CartSucessState({required this.totalPrice, required this.cartItems});
}

final class CartItemRemovedState extends CartActionState {
  final String productName;

  CartItemRemovedState({required this.productName});
}

final class CartEmptyState extends CartState {}


