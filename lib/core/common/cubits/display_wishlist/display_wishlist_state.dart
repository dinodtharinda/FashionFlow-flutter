part of 'display_wishlist_cubit.dart';

@immutable
sealed class DisplayWishlistState {}

final class DisplayWishlistInitial extends DisplayWishlistState {}

final class DisplayWishlistLoading extends DisplayWishlistState {}

final class DisplayWishlistSuccess extends DisplayWishlistState {
  final List<WishlistItem> wishlist;

  DisplayWishlistSuccess(this.wishlist);
}

final class DisplayWishlistFailure extends DisplayWishlistState {
  final String message;

  DisplayWishlistFailure(this.message);
}