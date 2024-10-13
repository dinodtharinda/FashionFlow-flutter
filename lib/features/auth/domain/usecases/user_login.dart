import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/common/entities/user.dart';
import 'package:fashion_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


import './../../../../core/usecase/usecase.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
