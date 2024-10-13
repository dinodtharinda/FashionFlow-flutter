import 'package:fashion_flow/core/common/entities/user.dart';
import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


import './../../../../core/usecase/usecase.dart';

class GetCurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return authRepository.getCurrentUser();
  }
}
