import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/core/common/entities/category.dart';
import 'package:fashion_flow/features/category/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllCategories implements UseCase<List<Category>, NoParams> {
  final CategoryRepository categoryRepository;

  GetAllCategories(this.categoryRepository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await categoryRepository.getAllCategories();
  }
}
