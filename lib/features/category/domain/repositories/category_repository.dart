import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/features/category/domain/entities/category.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
