import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedai_ayam_nina/core/theme.dart';
import 'package:kedai_ayam_nina/dependency_injection/dependency_injection.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/bloc/auth_bloc.dart';
import 'package:kedai_ayam_nina/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => getIt<AuthBloc>(),)
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.light,
      routerConfig: AppRouter().myRouter(),
    );
  }
}
