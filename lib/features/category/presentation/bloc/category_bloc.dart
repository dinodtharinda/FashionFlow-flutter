import 'dart:async';
import 'package:fashion_flow/core/common/cubits/display_categories/display_categories_cubit.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/core/common/entities/category.dart';
import 'package:fashion_flow/features/category/domain/usecases/get_all_categories.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategories _getAllCategories;
  final DisplayCatogoriesCubit _displayCatogoriesCubit;
  CategoryBloc(
      {required GetAllCategories getAllCategories,
      required DisplayCatogoriesCubit displayCatogoriesCubit})
      : _getAllCategories = getAllCategories,
        _displayCatogoriesCubit = displayCatogoriesCubit,
        super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) => emit(CategoryLoading()));
    on<CategoryFetchAll>(_onCategoryFetch);
  }

  FutureOr<void> _onCategoryFetch(
    CategoryFetchAll event,
    Emitter<CategoryState> emit,
  ) async {
    final res = await _getAllCategories(NoParams());

    res.fold(
      (l) => emit(CategoryFailure(l.message)),
      (r) => _emitSuccess(emit, r),
    );
  }

  void _emitSuccess(Emitter<CategoryState> emit, List<Category> categories) {
    _displayCatogoriesCubit.displayCategories(categories);
    emit(CategorySuccess(categories));
  }
}
