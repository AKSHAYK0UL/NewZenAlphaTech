import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/core/enums/auth_enums.dart';
import 'package:newzenalphatech/model/user.dart';
import 'package:newzenalphatech/repository/auth/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<SignUpEvent>(_signUp);
    on<SignInEvent>(_signIn);
    on<EmailVerificationEvent>(_verifcation);
    on<ForgotPasswordEvent>(_forgotPassword);
    on<SignOutEvent>(_signOut);
  }
  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState(loadingSource: AuthEnum.signUp));
    try {
      await _authRepo.signUp(event.user);
      emit(AuthSuccessState(successSource: AuthEnum.signUp));
    } catch (e) {
      emit(AuthErrorState(
          errorSource: AuthEnum.signUp, errorMessage: e.toString()));
    }
  }

  //email verfication
  Future<void> _verifcation(
      EmailVerificationEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState(loadingSource: AuthEnum.verification));
    try {
      final isVerified = await _authRepo.verifyEmail();
      if (isVerified) {
        emit(AuthSuccessState(successSource: AuthEnum.verification));
      } else {
        emit(
          AuthErrorState(
            errorSource: AuthEnum.verification,
            errorMessage: 'Email verification timed out or not verified.',
          ),
        );
      }
    } catch (e) {
      emit(
        AuthErrorState(
          errorSource: AuthEnum.verification,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState(loadingSource: AuthEnum.signIn));
    try {
      await _authRepo.signIn(event.user);
      emit(AuthSuccessState(successSource: AuthEnum.signIn));
    } catch (e) {
      emit(AuthErrorState(
          errorSource: AuthEnum.signIn,
          errorMessage: "Invalid Email or Password"));
    }
  }

  Future<void> _forgotPassword(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState(loadingSource: AuthEnum.forgot));
    try {
      await _authRepo.forgotPassword(event.email);
      emit(AuthSuccessState(successSource: AuthEnum.forgot));
    } catch (e) {
      emit(AuthErrorState(
          errorSource: AuthEnum.forgot, errorMessage: e.toString()));
    }
  }

  Future<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState(loadingSource: AuthEnum.signOut));
    try {
      await _authRepo.signOut();
      emit(AuthSuccessState(successSource: AuthEnum.signOut));
    } catch (e) {
      emit(AuthErrorState(
          errorSource: AuthEnum.signOut, errorMessage: e.toString()));
    }
  }
}
