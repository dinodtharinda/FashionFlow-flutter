part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistLoading extends WishlistState {}

final class WishlistFailure extends WishlistState {
  final String message;

  WishlistFailure(this.message);
}

final class WishlistDisplaySuccess extends WishlistState {
  final List<WishlistItem> wishlist;

  WishlistDisplaySuccess(this.wishlist);
}

final class WishlistToggleSuccess extends WishlistState {}

final class WishlistIsItemSuccess extends WishlistState {
  final bool isWishItem;

  WishlistIsItemSuccess(this.isWishItem);
  
}

