import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/features/wishlist/domain/entites/wishlist_item.dart';
import 'package:fashion_flow/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetWishlist implements UseCase<List<WishlistItem>, NoParams> {
  final WishlistRepository wishlistRepository;

  GetWishlist(this.wishlistRepository);

  @override
  Future<Either<Failure, List<WishlistItem>>> call(NoParams params) async {
    return await wishlistRepository.getWishList();
  }
}
