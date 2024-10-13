import 'dart:async';

import 'package:fashion_flow/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fashion_flow/core/common/entities/user.dart';
import 'package:fashion_flow/core/usecase/usecase.dart';
import 'package:fashion_flow/features/auth/domain/usecases/get_current_user.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_login.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_logout.dart';
import 'package:fashion_flow/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
  final GetCurrentUser _getCurrentUser;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;
  AuthBloc({
    required UserLogin userLogin,
    required UserSignUp userSignUp,
    required GetCurrentUser getCurrentUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout,
  })  : _userLogin = userLogin,
        _userSignUp = userSignUp,
        _getCurrentUser = getCurrentUser,
        _appUserCubit = appUserCubit,
        _userLogout = userLogout,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoding()));
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthGetCurrentUser>(_onGetCurrentUser);
    on<AuthLogout>(_onUserLogout);
  }

  FutureOr<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure( l.message)),
      (user) => _emitAuthSuccess(user, emit),
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
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> _onGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _getCurrentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> _onUserLogout(
      AuthLogout event, Emitter<AuthState> emit) async {
    await _userLogout(NoParams());
    _emitAuthSuccess(null, emit);
  }

    void _emitAuthSuccess(User? user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
