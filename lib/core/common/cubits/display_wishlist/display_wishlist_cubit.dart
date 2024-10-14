
import 'package:fashion_flow/core/common/entities/wishlist_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'display_wishlist_state.dart';

class DisplayWishlistCubit extends Cubit<DisplayWishlistState> {
  DisplayWishlistCubit() : super(DisplayWishlistLoading());

  void display(List<WishlistItem>? wishlist) {
    if (wishlist != null) {
      emit(DisplayWishlistSuccess(wishlist));
    } else {
      emit(DisplayWishlistFailure());
    }
  }
}
