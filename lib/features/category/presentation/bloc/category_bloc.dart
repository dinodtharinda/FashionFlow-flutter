import 'dart:async';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/features/category/domain/entities/category.dart';
import 'package:fashion_flow/features/category/domain/usecases/get_all_categories.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategories _getAllCategories;
  CategoryBloc({required GetAllCategories getAllCategories})
      : _getAllCategories = getAllCategories,
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
      (r) => emit(CategorySuccess(r)),
    );
  }
}
