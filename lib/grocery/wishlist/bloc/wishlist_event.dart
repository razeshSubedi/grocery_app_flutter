part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

final class WishlistInitialEvent extends WishlistEvent{}

final class WishlistItemRemovedEvent extends WishlistEvent{
  final ProductsDataModel removedItem;

  WishlistItemRemovedEvent({required this.removedItem});
}
