part of 'display_products_cubit.dart';

@immutable
sealed class DisplayProductsState {}

final class DisplayProductsInitial extends DisplayProductsState {}

final class DisplayProductsLoading extends DisplayProductsState {}

final class DisplayProductsSuccess extends DisplayProductsState {
  final List<Product> products;

  DisplayProductsSuccess(this.products);
}

final class DisplayProductsFailure extends DisplayProductsState {}
