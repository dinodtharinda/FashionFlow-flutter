import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      final res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = res.user;
      if (user == null) {
        throw ServerException('User is null!');
      }

      return UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email!,
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'firebase auth error!');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithPassword(
      {required String email, required String password}) async {
    try {
      final res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = res.user;
      if (user == null) {
        throw ServerException('User is null!');
      }

      return UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email!,
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'firebase auth error!');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
