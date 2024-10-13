import 'package:fashion_flow/core/api/http/http_service.dart';
import 'package:fashion_flow/core/constants/constants.dart';
import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/features/category/data/models/category_model.dart';

abstract interface class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final HttpService httpService;

  CategoryRemoteDataSourceImpl(this.httpService);
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final res =
          await httpService.getData(uri: AppConstants.GET_ALL_CATEGORIES);

      if (res.data == null) {
        throw ServerException('categories null!');
      }

      if (res.data is List) {
        
        final List<CategoryModel> categories =
            res.data.map<CategoryModel>((category) {
          return CategoryModel.fromJson(category);
        }).toList();
        return categories;

      } else {
        throw ServerException('categories not a list');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
