import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/features/category/data/datasource/category_remote_data_source.dart';
import 'package:fashion_flow/features/category/domain/entities/category.dart';
import 'package:fashion_flow/features/category/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';


class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final categories = await remoteDataSource.getAllCategories();
      return right(categories);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
