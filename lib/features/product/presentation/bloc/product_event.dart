part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class ProductFetchAll extends ProductEvent {}
