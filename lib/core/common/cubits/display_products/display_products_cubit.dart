
import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'display_products_state.dart';

class DisplayProductsCubit extends Cubit<DisplayProductsState> {
  DisplayProductsCubit() : super(DisplayProductsLoading());
  
  void display(List<Product>? products) {
    if (products != null) {
      emit(DisplayProductsSuccess(products));
    } else {
      emit(DisplayProductsFailure());
    }
  }
}
