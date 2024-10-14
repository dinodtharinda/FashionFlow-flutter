part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductFailure extends ProductState {
  final String messaage;

  ProductFailure(this.messaage);
}

final class ProductSuccess extends ProductState {
  final List<Product> products;

  ProductSuccess(this.products);
  
}
