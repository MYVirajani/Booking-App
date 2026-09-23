import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}


class AuthSessionCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String phone;
  final String password;
  const AuthLoginRequested({required this.phone, required this.password});
  @override
  List<Object?> get props => [phone, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String phone;
  final String password;
  final String? email;
  const AuthRegisterRequested({
    required this.name,
    required this.phone,
    required this.password,
    this.email,
  });
  @override
  List<Object?> get props => [name, phone, password, email];
}

class AuthLogoutRequested extends AuthEvent {}