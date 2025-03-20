part of 'auth_state_bloc.dart';

sealed class AuthStateEvent {}

final class UserLoggedInDetectedEvent extends AuthStateEvent {}

final class UserLoggedOutDetectedEvent extends AuthStateEvent {}
