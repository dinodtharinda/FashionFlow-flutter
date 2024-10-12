import 'package:fashion_flow/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.gender,
  });
}
