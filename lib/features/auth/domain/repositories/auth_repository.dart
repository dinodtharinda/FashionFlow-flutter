import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,User>> loginWithPassword({required String email, required String password});
  Future<Either<Failure,User>>  signUpWithPassword({required String email, required String password});
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure,bool>> logout();
}