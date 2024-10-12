import 'dart:async';

import 'package:fashion_flow/features/auth/domain/entities/user.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_login.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
  })  : _userLogin = userLogin,
        _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoding()));
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignUp>(_onAuthSignUp);
  }

  FutureOr<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => AuthSuccess(user: r),
    );
  }

  FutureOr<void> _onAuthSignUp(
      AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(user: r)),
    );
  }
}
