part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {
  final AuthEnum loadingSource;

  AuthLoadingState({required this.loadingSource});
}

final class AuthErrorState extends AuthState {
  final String errorMessage;
  final AuthEnum errorSource;

  AuthErrorState({required this.errorSource, required this.errorMessage});
}

final class AuthSuccessState extends AuthState {
  final AuthEnum successSource;

  AuthSuccessState({required this.successSource});
}
