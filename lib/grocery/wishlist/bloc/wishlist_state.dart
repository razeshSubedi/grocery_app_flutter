part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistActionState extends WishlistState{}

final class WishlistInitial extends WishlistState {}

final class WishlistLoadingState extends WishlistState{}

final class WishlistPageLoadedState extends WishlistState{
  final List<ProductsDataModel> wishlistedProducts;

  WishlistPageLoadedState({required this.wishlistedProducts});
}


final class WishlistItemRemovedStata extends WishlistActionState{
  final String removedProduct;

  WishlistItemRemovedStata({required this.removedProduct});
}

final class WishlistEmptyState extends WishlistState{}

