import 'package:fashion_flow/core/api/firebase/firestore_api.dart';
import 'package:fashion_flow/core/api/http/http_service.dart';
import 'package:fashion_flow/core/common/cubits/app_user/app_user_cubit.dart';
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
import 'package:fashion_flow/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initCategory();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  FirebaseFirestoreAPI().initFirestore();
  SharedPreferences sp = await SharedPreferences.getInstance();

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator
      .registerLazySingleton(() => HttpService(AppConstants.BASE_URL, sp));
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
