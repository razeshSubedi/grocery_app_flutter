part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveItemEvent extends CartEvent{ 
  final ProductsDataModel cartItemToBeDeleted;

  CartRemoveItemEvent({required this.cartItemToBeDeleted});
}

class CartItemWishlistedEvent extends CartEvent{
  final ProductsDataModel wishlistedItem;

  CartItemWishlistedEvent({required this.wishlistedItem});
}
