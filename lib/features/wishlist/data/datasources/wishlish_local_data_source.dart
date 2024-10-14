import 'package:flutter/material.dart';

import '/core/common/entities/product.dart';
import '/core/error/exception.dart';
import '/features/wishlist/data/models/wishlist_item_model.dart';

abstract interface class WishListLocalDataSource {
  List<WishlistItemModel> get wishlist;
  Future<bool> addToWishlist(Product product);
  Future<bool> isWishItem(int id);
}

class WIshListLocalDataSourceImpl
    with ChangeNotifier
    implements WishListLocalDataSource {
  final List<WishlistItemModel> _wishlist = [];
  @override
  List<WishlistItemModel> get wishlist => _wishlist;

  @override
  Future<bool> isWishItem(int id) async {
    return hasProductInWishlist(id);
  }

  @override
  Future<bool> addToWishlist(Product product) async {
    try {
      final isContain = hasProductInWishlist(product.id);
      if (isContain) {
        _removeProductFromWishlist(product.id);
        return false;
      } else {
        final newWishlistItem = WishlistItemModel(
          id: product.id,
          product: product,
          addedDate: DateTime.now(),
        );
        _wishlist.add(newWishlistItem);
        return true;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  bool hasProductInWishlist(int productId) {
    return _wishlist.any((item) => item.id == productId);
  }

  void _removeProductFromWishlist(int productId) {
    _wishlist.removeWhere((item) => item.id == productId);
  }
}
