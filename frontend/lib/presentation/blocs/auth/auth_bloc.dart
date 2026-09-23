import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api_client.dart';
import '../../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSessionCheckRequested>(_onSessionCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onSessionCheckRequested(
      AuthSessionCheckRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    final loggedIn = await AuthService.isLoggedIn();
    if (!loggedIn) {
      emit(AuthUnauthenticated());
      return;
    }
    try {
      final user = await AuthService.getMe();
      emit(AuthAuthenticated(user));
    } catch (_) {
      // saved token is invalid/expired
      await AuthService.logout();
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await AuthService.login(phone: event.phone, password: event.password);
      final user = await AuthService.getMe();
      emit(AuthAuthenticated(user));
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (_) {
      emit(const AuthFailure("Couldn't reach the server. Check your connection."));
    }
  }

  Future<void> _onRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await AuthService.register(
        name: event.name,
        phone: event.phone,
        password: event.password,
        email: event.email,
      );
      emit(AuthRegisterSuccess());
    } on ApiException catch (e) {
      emit(AuthFailure(e.message));
    } catch (_) {
      emit(const AuthFailure("Couldn't reach the server. Check your connection."));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await AuthService.logout();
    emit(AuthUnauthenticated());
  }
}