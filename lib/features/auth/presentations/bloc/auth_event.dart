part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;

  AuthRegister({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
  });
}

final class AuthLogout extends AuthEvent {}

final class AuthCheck extends AuthEvent {
  final User? user;
  AuthCheck({required this.user});
}
