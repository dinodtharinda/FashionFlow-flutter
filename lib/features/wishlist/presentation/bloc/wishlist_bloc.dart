import 'dart:async';

import 'package:fashion_flow/core/common/cubits/display_wishlist/display_wishlist_cubit.dart';
import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/core/common/entities/wishlist_item.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/is_wish_item.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/toggle_wish_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlist _getWishlist;
  final IsWishItem _isWishItem;
  final DisplayWishlistCubit _displayWishlistCubit;
  WishlistBloc({
    required GetWishlist getWishlist,
    required ToggleWishItem toggleWishItem,
    required IsWishItem isWishItem,
    required DisplayWishlistCubit displayWishlistCubit,
  })  : 
        _getWishlist = getWishlist,
        _isWishItem = isWishItem,
        _displayWishlistCubit = displayWishlistCubit,
        super(WishlistInitial()) {
    on<WishlistEvent>((event, emit) => emit(WishlistLoading()));
    on<WishlistFetchAll>(_onFetchWishlist);
    // on<WishlistToggle>(_toggleToWishlist);
    on<WishlsitIsWishItem>(_onIsWishItem);
  }

  FutureOr<void> _onFetchWishlist(
    WishlistFetchAll event,
    Emitter<WishlistState> emit,
  ) async {
    final res = await _getWishlist(NoParams());

    res.fold(
      (l) => _emitFailure(emit, l.message),
      (r) => _emitSuccess(emit, r),
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

  void _emitSuccess(Emitter<WishlistState> emit, List<WishlistItem> wishlist) {
    _displayWishlistCubit.success(wishlist);
    emit(WishlistToggleSuccess(wishlist));
  }

  void _emitFailure(Emitter<WishlistState> emit, String error) {
    _displayWishlistCubit.failure(error);
    emit(WishlistFailure(error));
  }
}
