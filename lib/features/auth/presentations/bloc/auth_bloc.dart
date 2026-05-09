import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final Logout logout;

  AuthBloc({
    required this.login,
    required this.register,
    required this.logout,
  }) : super(AuthInitial()) {
    on<AuthLogin>(_onAuthLogin);
    on<AuthRegister>(_onAuthRegister);
    on<AuthLogout>(_onAuthLogout);
  }

  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgress());
      await login(event.email, event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onAuthRegister(AuthRegister event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgress());
      await register(event.email, event.password, event.name);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      emit(AuthInProgress());
      await logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: e.toString().replaceAll('Exception: ', '')));
    }
  }
}
