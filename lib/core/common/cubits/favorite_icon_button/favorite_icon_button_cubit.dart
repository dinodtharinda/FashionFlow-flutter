import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/is_wish_item.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/toggle_wish_item.dart';
import 'package:fashion_flow/init_dependencies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconButtonCubit extends Cubit<bool> {
  FavoriteIconButtonCubit() : super(false);

  void isFavorite(int id) async {
    var res = await serviceLocator<IsWishItem>().call(
      IsWishParams(id: id),
    );
    res.fold((l) {}, (r) => emit(r));
  }

  void onTap(Product product) async {
    var res = await serviceLocator<ToggleWishItem>().call(
      ToggleWishParams(product: product),
    );

    res.fold(
      (l) {},
      (r) => emit(r),
    );
  }
}
