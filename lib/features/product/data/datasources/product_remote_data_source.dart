import 'package:fashion_flow/core/api/http/http_service.dart';
import 'package:fashion_flow/core/constants/constants.dart';
import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/features/product/data/models/product_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(String id);
  Future<List<ProductModel>> getProductsByCategory();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final HttpService httpService;

  ProductRemoteDataSourceImpl(this.httpService);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final res = await httpService.getData(uri: AppConstants.GET_ALL_PRODUCTS);
      if (res.data['products'] is List) {
        final products = (res.data['products'] as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();
        return products;
      } else {
        throw ServerException('product list is not a list!');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProduct(String id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory() {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }
}
