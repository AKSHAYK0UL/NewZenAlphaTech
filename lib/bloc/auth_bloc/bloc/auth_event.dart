part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final User user;

  SignUpEvent({required this.user});
}

final class SignInEvent extends AuthEvent {
  final User user;

  SignInEvent({required this.user});
}

final class EmailVerificationEvent extends AuthEvent {}

final class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

final class SignOutEvent extends AuthEvent {}
