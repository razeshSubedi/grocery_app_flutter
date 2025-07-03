part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadingSucessState extends HomeState {
  final List<ProductsDataModel> products;
  HomeLoadingSucessState({required this.products});
}

final class HomeErrorState extends HomeState {}

final class NavigateToWishlistPageState extends HomeActionState {}

final class NavigateToCartPageState extends HomeActionState {}

final class ProductAddedToWishlistState extends HomeActionState {
  final String message;

  ProductAddedToWishlistState({required this.message});
}

final class ProductAddedToCartState extends HomeActionState {
  final String message;

  ProductAddedToCartState({required this.message});
}
