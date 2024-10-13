import 'package:fashion_flow/core/api/firebase/firebase_messaging_api.dart';
import 'package:fashion_flow/core/api/firebase/firestore_api.dart';
import 'package:fashion_flow/core/error/exception.dart';
import 'package:fashion_flow/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDateSource {
  Future<UserModel> loginWithPassword(
      {required String email, required String password});
  Future<UserModel> signUpWithPassword(
      {required String email, required String password});

  Future<UserModel> getCurrentUser();

  Future<void> logout();
}

class AuthRemoteDateSourceImpl implements AuthRemoteDateSource {
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final res = firebaseAuth.currentUser;

      if (res == null) {
        throw ServerException('User is null!');
      }

      final user = UserModel(
        id: res.uid,
        name: res.displayName ?? '',
        email: res.email!,
        token:  '',
      );
      
      return user;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'firebase auth error!');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseMessagingAPI().disposeNotifications();
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel> loginWithPassword(
      {required String email, required String password}) async {
    try {
      final res = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (res.user == null) {
        throw ServerException('User is null!');
      }

      final token = await FirebaseMessagingAPI().initNotifications();
      final user = UserModel(
          id: res.user!.uid,
          name: res.user!.displayName ?? '',
          email: res.user!.email!,
          token: token);
      await FirebaseFirestoreAPI().saveUser(user.id, user);

      return user;
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
      final res = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (res.user == null) {
        throw ServerException('User is null!');
      }

      final token = await FirebaseMessagingAPI().initNotifications();
      final user = UserModel(
          id: res.user!.uid,
          name: res.user!.displayName ?? '',
          email: res.user!.email!,
          token: token);
      await FirebaseFirestoreAPI().saveUser(user.id, user);

      return user;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'firebase auth error!');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
