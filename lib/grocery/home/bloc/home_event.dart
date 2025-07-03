part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class WishlistButtonClicked extends HomeEvent {
  final ProductsDataModel clickedWishlistItem;

  WishlistButtonClicked({required this.clickedWishlistItem});
}

class CartButtonClicked extends HomeEvent {
  final ProductsDataModel clickedCartItem;

  CartButtonClicked({required this.clickedCartItem});
}

class WishlistNavigationButtonClicked extends HomeEvent {}

class CartNavigationButtonClicked extends HomeEvent {}
