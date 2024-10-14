import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:fpdart/fpdart.dart';

class ToggleWishItem implements UseCase<bool, ToggleWishParams> {
  final WishlistRepository wishlistRepository;

  ToggleWishItem(this.wishlistRepository);

  @override
  Future<Either<Failure, bool>> call(ToggleWishParams params) async {
    return await wishlistRepository.toggleToWishlist(params.product);
  }
}

class ToggleWishParams {
  final Product product;

  ToggleWishParams({
    required this.product,
  });
}
