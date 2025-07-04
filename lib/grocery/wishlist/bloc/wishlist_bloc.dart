import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/data/cart_items.dart';
import 'package:grocery_app/data/wishlist_items.dart';
import 'package:grocery_app/grocery/models/data_model.dart';


import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>((event, emit) async {
      emit(WishlistLoadingState());
      await Future.delayed(Duration(seconds: 1));
      emit(WishlistPageLoadedState(wishlistedProducts: wishlistItems));
      if (wishlistItems.isEmpty) {
        emit(WishlistEmptyState());
      }
    });

    on<WishlistItemRemovedEvent>((event, emit) {
      wishlistItems.remove(event.removedItem);
      emit(WishlistItemRemovedStata(removedProduct: event.removedItem.name));
      emit(WishlistPageLoadedState(wishlistedProducts: wishlistItems));
      if (wishlistItems.isEmpty) {
        emit(WishlistEmptyState());
      }
    });
    
    on<WishlistItemCartedEvent>((event, emit) {
      cartItems.add(event.cartedItem);
      emit(WishlistItemCartedState(cartedItemName: event.cartedItem.name));
      
    });
  }
}
