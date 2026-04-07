import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../domain/services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthService authService;

  AuthBloc() : super(AuthInitial()) {
    authService = AuthService(AuthRepository());

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await authService.login(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}