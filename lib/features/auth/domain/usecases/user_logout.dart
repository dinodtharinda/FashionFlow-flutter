import 'package:fashion_flow/core/error/failures.dart';
import 'package:fashion_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


import './../../../../core/usecase/usecase.dart';

class UserLogout implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  UserLogout(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
