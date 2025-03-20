part of 'auth_state_bloc.dart';

sealed class AuthStateState {}

final class AuthStateInitial extends AuthStateState {}

final class LoggedInState extends AuthStateState {}
