import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';


class GetAllProducts implements UseCase<List<Product>,NoParams>{
  final ProductRepository productRepository;

  GetAllProducts(this.productRepository);
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params)async {
   return await productRepository.getAllProducts();
  }
  
}