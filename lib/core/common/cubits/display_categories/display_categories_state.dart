part of 'display_categories_cubit.dart';

@immutable
sealed class DisplayCategoriesState {}

final class DisplayCategoriesInitial extends DisplayCategoriesState {}

final class DisplayCategoriesLoading extends DisplayCategoriesState {}

final class DisplayCategoriesSuccess extends DisplayCategoriesState {
  final List<Category> categories;

  DisplayCategoriesSuccess(this.categories);
}

final class DisplayCategoriesFailure extends DisplayCategoriesState {}
