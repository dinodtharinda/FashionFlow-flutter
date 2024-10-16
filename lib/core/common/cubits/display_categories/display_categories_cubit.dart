import 'package:fashion_flow/core/common/entities/category.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'display_categories_state.dart';

class DisplayCatogoriesCubit extends Cubit<DisplayCategoriesState> {
  DisplayCatogoriesCubit() : super(DisplayCategoriesLoading());

  void success(List<Category>? categories) {
    if (categories != null) {
      emit(DisplayCategoriesSuccess(categories));
    } else {
      emit(DisplayCategoriesFailure('category is null'));
    }
  }

  void failure(String error) {
    emit(DisplayCategoriesFailure(error));
  }
}
