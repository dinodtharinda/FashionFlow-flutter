import 'package:fashion_flow/core/api/firebase/firestore_api.dart';
import 'package:fashion_flow/core/api/http/http_service.dart';
import 'package:fashion_flow/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fashion_flow/core/common/cubits/display_categories/display_categories_cubit.dart';
import 'package:fashion_flow/core/common/cubits/display_products/display_products_cubit.dart';
import 'package:fashion_flow/core/common/cubits/display_wishlist/display_wishlist_cubit.dart';
import 'package:fashion_flow/core/constants/constants.dart';
import 'package:fashion_flow/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fashion_flow/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fashion_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fashion_flow/features/auth/domain/usecases/get_current_user.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_login.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_logout.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_sign_up.dart';
import 'package:fashion_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fashion_flow/features/category/data/datasource/category_remote_data_source.dart';
import 'package:fashion_flow/features/category/data/repositories/category_repository_impl.dart';
import 'package:fashion_flow/features/category/domain/repositories/category_repository.dart';
import 'package:fashion_flow/features/category/domain/usecases/get_all_categories.dart';
import 'package:fashion_flow/features/category/presentation/bloc/category_bloc.dart';
import 'package:fashion_flow/features/product/data/datasources/product_remote_data_source.dart';
import 'package:fashion_flow/features/product/data/repositories/product_repository_impl.dart';
import 'package:fashion_flow/features/product/domain/repositories/product_repository.dart';
import 'package:fashion_flow/features/product/domain/usecases/get_all_products.dart';
import 'package:fashion_flow/features/product/presentation/bloc/product_bloc.dart';
import 'package:fashion_flow/features/wishlist/data/datasources/wishlish_local_data_source.dart';
import 'package:fashion_flow/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:fashion_flow/core/common/repositories/wishlist_repository.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/get_wishlist.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/is_wish_item.dart';
import 'package:fashion_flow/features/wishlist/domain/usecases/toggle_wish_item.dart';
import 'package:fashion_flow/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fashion_flow/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initCategory();
  _initProduct();
  _initWishlist();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestoreAPI().initFirestore();
  SharedPreferences sp = await SharedPreferences.getInstance();

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(() => DisplayCatogoriesCubit());
  serviceLocator.registerLazySingleton(() => DisplayProductsCubit());
  serviceLocator.registerLazySingleton(() => DisplayWishlistCubit());
  // serviceLocator.registerLazySingleton(() => FavoriteIconButtonCubit());


  serviceLocator
      .registerLazySingleton(() => HttpService(AppConstants.BASE_URL, sp));
}

void _initWishlist() {
  serviceLocator
    ..registerLazySingleton<WishListLocalDataSource>(
      () => WIshListLocalDataSourceImpl(),
    )
    ..registerFactory<WishlistRepository>(
      () => WishlistRepositoyImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetWishlist(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ToggleWishItem(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => IsWishItem(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => WishlistBloc(
          getWishlist: serviceLocator(),
          toggleWishItem: serviceLocator(),
          isWishItem: serviceLocator(),
          displayWishlistCubit: serviceLocator()),
    );
}

void _initProduct() {
  serviceLocator
    ..registerFactory<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllProducts(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ProductBloc(
        getAllProducts: serviceLocator(),
        displayProductsCubit: serviceLocator(),
      ),
    );
}

void _initCategory() {
  serviceLocator
    ..registerFactory<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<CategoryRepository>(
      () => CategoryRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllCategories(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => CategoryBloc(
        getAllCategories: serviceLocator(),
        displayCatogoriesCubit: serviceLocator(),
      ),
    );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDateSource>(
      () => AuthRemoteDateSourceImpl(),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetCurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogout(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
          userLogin: serviceLocator(),
          userSignUp: serviceLocator(),
          getCurrentUser: serviceLocator(),
          appUserCubit: serviceLocator(),
          userLogout: serviceLocator()),
    );
}
