import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/grocery/models/data_model.dart';
import 'package:grocery_app/services/supabase_service.dart';
import 'package:flutter/material.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>((event, emit) async {
      emit(WishlistLoadingState());
      final wishlistProducts = await SupabaseService().fetchWishlist();

      if (wishlistProducts.isEmpty) {
        emit(WishlistEmptyState());
      } else {
        emit(WishlistPageLoadedState(wishlistedProducts: wishlistProducts));
      }
    });

    on<WishlistItemRemovedEvent>((event, emit) async {
      await SupabaseService().removeFromWishlist(event.removedItem.id);
      emit(WishlistItemRemovedStata(removedProduct: event.removedItem.name));
      final wishlistProducts = await SupabaseService().fetchWishlist();

      if (wishlistProducts.isEmpty) {
        emit(WishlistEmptyState());
      } else {
        emit(WishlistPageLoadedState(wishlistedProducts: wishlistProducts));
      }
    });

    on<WishlistItemCartedEvent>((event, emit) async {
      await SupabaseService().addToCart(event.cartedItem.id);
      emit(WishlistItemCartedState(cartedItemName: event.cartedItem.name));
    });
  }
}
