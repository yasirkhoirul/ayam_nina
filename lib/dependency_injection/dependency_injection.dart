
import 'package:get_it/get_it.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/bloc/auth_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async {
  // Register your dependencies here
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(),);
}