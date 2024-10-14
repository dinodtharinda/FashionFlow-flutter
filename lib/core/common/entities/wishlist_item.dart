import 'package:fashion_flow/core/common/entities/product.dart';

class WishlistItem {
  final int id;
  final Product product;
  final DateTime addedDate;

  WishlistItem({
    required this.id,
    required this.product,
    required this.addedDate,
  });
}
