import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/features/product/data/datasources/product_remote_data_source.dart';
import 'package:fashion_flow/features/product/domain/entities/product.dart';
import 'package:fashion_flow/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final res = await productRemoteDataSource.getAllProducts();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProductsByCategory(
      String category) {
    // TODO: implement getAllProductsByCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }
}
