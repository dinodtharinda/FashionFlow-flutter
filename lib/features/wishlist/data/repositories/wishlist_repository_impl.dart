import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/features/wishlist/data/datasources/wishlish_local_data_source.dart';
import 'package:fashion_flow/core/common/entities/wishlist_item.dart';
import 'package:fashion_flow/core/common/repositories/wishlist_repository.dart';
import 'package:fpdart/fpdart.dart';


class WishlistRepositoyImpl  implements WishlistRepository{
  final WishListLocalDataSource wishListLocalDataSource;

  WishlistRepositoyImpl(this.wishListLocalDataSource);
  @override
  Future<Either<Failure, List<WishlistItem>>> getWishList() async {
    try {
      return right( wishListLocalDataSource.wishlist);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isWishItem(int id) async {
    try {
      return right(await wishListLocalDataSource.isWishItem(id));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleToWishlist(Product product) async {
    try {
      return right(await wishListLocalDataSource.addToWishlist(product));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
