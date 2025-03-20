import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state_event.dart';
part 'auth_state_state.dart';

class AuthStateBloc extends Bloc<AuthStateEvent, AuthStateState> {
  final FirebaseAuth firebaseAuthInstance;
  late final StreamSubscription<User?> _authSubscription;

  AuthStateBloc(this.firebaseAuthInstance) : super(AuthStateInitial()) {
    _authSubscription = firebaseAuthInstance.authStateChanges().listen((user) {
      if (user != null) {
        add(UserLoggedInDetectedEvent());
      } else {
        add(UserLoggedOutDetectedEvent());
      }
    });
    on<UserLoggedInDetectedEvent>(
        (UserLoggedInDetectedEvent event, Emitter<AuthStateState> emit) =>
            emit(LoggedInState()));
    on<UserLoggedOutDetectedEvent>(
        (UserLoggedOutDetectedEvent event, Emitter<AuthStateState> emit) =>
            emit(AuthStateInitial()));
  }

  @override
  Future<void> close() async {
    _authSubscription.cancel();
    return super.close();
  }
}
