import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/core/common/entities/user.dart';
import 'package:fashion_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


import './../../../../core/usecase/usecase.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.password,
  });
}
