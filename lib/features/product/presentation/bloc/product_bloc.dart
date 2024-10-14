import 'dart:async';

import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/features/product/domain/entities/product.dart';
import 'package:fashion_flow/features/product/domain/usecases/get_all_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts _getAllProducts;
  ProductBloc({required GetAllProducts getAllProducts})
      : _getAllProducts = getAllProducts,
        super(ProductInitial()) {
    on<ProductEvent>((_, emit) => emit(ProductLoading()));
    on<ProductFetchAll>(_onFetchAllProduct);
  }

  FutureOr<void> _onFetchAllProduct(
      ProductFetchAll event, Emitter<ProductState> emit) async {
    final res = await _getAllProducts(NoParams());

    res.fold(
      (l) => emit(ProductFailure(l.message)),
      (r) => emit(ProductSuccess(r)),
    );
  }
}
