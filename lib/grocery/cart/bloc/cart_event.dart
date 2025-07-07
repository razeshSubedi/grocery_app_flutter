part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveItemEvent extends CartEvent{ 
  final CartItemModel cartItemToBeDeleted;

  CartRemoveItemEvent({required this.cartItemToBeDeleted});
}


class CartQuantityChangedEvent extends CartEvent {
 final int productId;
 final int updatedQuantity;

  CartQuantityChangedEvent({required this.updatedQuantity, required this.productId});
}

class CartCheckoutEvent extends CartEvent {}