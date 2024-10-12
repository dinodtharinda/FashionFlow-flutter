import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDateSource {
  Future<UserModel> loginWithPassword(
      {required String email, required String password});
  Future<UserModel> signUpWithPassword(
      {required String email, required String password});
}

class AuthRemoteDateSourceImpl implements AuthRemoteDateSource {
  @override
  Future<UserModel> loginWithPassword(
      {required String email, required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (email != 'dinodtharinda2001@gmail.com' && password != '12345678') {
        throw Exception('incorrect credentials');
      }
      return UserModel(
          firstName: 'Dinod',
          lastName: 'Tharinda',
          email: 'dinodtharinda2001@gmail.com',
          gender: 'male');
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithPassword(
      {required String email, required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (email != 'dinodtharinda2001@gmail.com' && password != '12345678') {
        throw ServerException('incorrect credentials');
      }
      return UserModel(
          firstName: 'Dinod',
          lastName: 'Tharinda',
          email: 'dinodtharinda2001@gmail.com',
          gender: 'male');
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
