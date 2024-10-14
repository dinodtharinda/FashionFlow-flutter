import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProductRepository {
  Future<Either<Failure,List<Product>>> getAllProducts();
  Future<Either<Failure,List<Product>>> getAllProductsByCategory(String category);
  Future<Either<Failure,Product>> getProductById(String id);
}