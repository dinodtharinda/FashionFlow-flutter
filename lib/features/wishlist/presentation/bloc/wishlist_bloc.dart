import 'dart:async';

import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/features/wishlist/domain/entites/wishlist_item.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/is_wish_item.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/toggle_wish_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlist _getWishlist;
  final ToggleWishItem _toggleWishItem;
  final IsWishItem _isWishItem;
  WishlistBloc(
      {required GetWishlist getWishlist,
      required ToggleWishItem toggleWishItem,
      required IsWishItem isWishItem})
      : _toggleWishItem = toggleWishItem,
        _getWishlist = getWishlist,
        _isWishItem = isWishItem,
        super(WishlistInitial()) {
    on<WishlistEvent>((event, emit) => emit(WishlistLoading()));
    on<WishlistFetchAll>(_onFetchWishlist);
    on<WishlistToggle>(_toggleToWishlist);
    on<WishlsitIsWishItem>(_onIsWishItem);
  }

  FutureOr<void> _onFetchWishlist(
    WishlistFetchAll event,
    Emitter<WishlistState> emit,
  ) async {
    final res = await _getWishlist(NoParams());

    res.fold(
      (l) => emit(WishlistFailure(l.message)),
      (r) => emit(WishlistDisplaySuccess(r)),
    );
  }

  FutureOr<void> _toggleToWishlist(
    WishlistToggle event,
    Emitter<WishlistState> emit,
  ) async {
    final res = await _toggleWishItem(ToggleWishParams(product: event.product));

    res.fold(
      (l) => emit(WishlistFailure(l.message)),
      (r) => emit(WishlistToggleSuccess()),
    );
  }

  FutureOr<void> _onIsWishItem(
      WishlsitIsWishItem event, Emitter<WishlistState> emit) async {
    final res = await _isWishItem(IsWishParams(id: event.id));

    res.fold(
      (l) => emit(WishlistFailure(l.message)),
      (r) => emit(WishlistIsItemSuccess(r)),
    );
  }
}
