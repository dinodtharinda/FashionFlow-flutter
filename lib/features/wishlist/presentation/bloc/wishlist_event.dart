part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

final class WishlistFetchAll extends WishlistEvent {}

final class WishlistToggle extends WishlistEvent {
  final Product product;

  WishlistToggle({
    required this.product,
  });
}

final class WishlsitIsWishItem extends WishlistEvent{
  final int id;

  WishlsitIsWishItem({required this.id});
}
