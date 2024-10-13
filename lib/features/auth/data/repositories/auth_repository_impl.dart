import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fashion_flow/core/common/entities/user.dart';
import 'package:fashion_flow/features/auth/data/models/user_model.dart';
import 'package:fashion_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDateSource remoteDateSource;

  AuthRepositoryImpl(this.remoteDateSource);

  @override
  Either<Failure, User> getCurrentUser() {
    try {
      return right(remoteDateSource.getCurrentUser());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    await remoteDateSource.logout();
    return right(true);
  }

  @override
  Future<Either<Failure, User>> loginWithPassword(
      {required String email, required String password}) async {
    try {
      final user = await remoteDateSource.loginWithPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithPassword(
      {required String email, required String password}) async {
    try {
      final user = await remoteDateSource.signUpWithPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
