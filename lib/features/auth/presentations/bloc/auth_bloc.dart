import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>(_onAuthLogin);
    on<AuthRegister>(_onAuthRegister);
    on<AuthLogout>(_onAuthLogout);
  }

  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgress());

      // TODO: Implement login logic here
      // - Validate email/password format
      // - Call API/repository to authenticate
      // - Save auth token if successful

      // Placeholder: simulate login success after 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      // You can emit success or failure based on your authentication logic
      emit(AuthSuccess());

      // Or emit failure if authentication fails:
      // emit(AuthFailure(message: 'Invalid email or password'));
    } catch (e) {
      emit(AuthFailure(message: 'Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onAuthRegister(AuthRegister event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgress());

      // TODO: Implement register logic here
      // - Validate email format
      // - Validate password strength
      // - Check password and confirm password match
      // - Call API/repository to register
      // - Save auth token if successful

      // Placeholder: simulate registration success after 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      // You can emit success or failure based on your registration logic
      emit(AuthSuccess());

      // Or emit failure if registration fails:
      // emit(AuthFailure(message: 'Registration failed, email already exists'));
    } catch (e) {
      emit(AuthFailure(message: 'Registration failed: ${e.toString()}'));
    }
  }

  Future<void> _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgress());

      // TODO: Implement logout logic here
      // - Clear auth token
      // - Call API to logout if needed
      // - Clear cached user data

      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: 'Logout failed: ${e.toString()}'));
    }
  }
}
