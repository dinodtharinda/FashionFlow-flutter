import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/core/common/repositories/wishlist_repository.dart';
import 'package:fpdart/fpdart.dart';

class IsWishItem implements UseCase<bool, IsWishParams> {
  final WishlistRepository wishlistRepository;

  IsWishItem(this.wishlistRepository);
  @override
  Future<Either<Failure, bool>> call(IsWishParams params) async {
    return await wishlistRepository.isWishItem(params.id);
  }
}

class IsWishParams {
  final int id;

  IsWishParams({required this.id});
}
