import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/common/entities/wishlist_item.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class WishlistRepository {
  Future<Either<Failure,List<WishlistItem>>> getWishList();
  Future<Either<Failure,List<WishlistItem>>> toggleToWishlist(Product  product);
  Future<Either<Failure,bool>> isWishItem(int id);
}