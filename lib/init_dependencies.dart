import 'package:fashion_flow/core/api/firebase_api.dart';
import 'package:fashion_flow/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fashion_flow/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fashion_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_login.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_sign_up.dart';
import 'package:fashion_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
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
    ..registerLazySingleton(
      () => AuthBloc(
        userLogin: serviceLocator(),
        userSignUp: serviceLocator(),
      ),
    );
}
