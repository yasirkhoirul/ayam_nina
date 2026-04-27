import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/component/main_scaffold_auth.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/login_page.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/sign_up_page.dart';
import 'package:kedai_ayam_nina/features/home/pages/home.dart';
import 'package:kedai_ayam_nina/router/router.dart';

class AppRouter {
  GoRouter myRouter({BlocBase? bloc}) {
    return GoRouter(
      initialLocation: MyRoute.login.path,
      routes: [
        GoRoute(path: MyRoute.home.path, builder: (context, state) => Home()),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => MainScaffoldAuth(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: MyRoute.login.path,
                  builder: (context, state) => const LoginPage(),
                ),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                path: MyRoute.signup.path,
                builder: (context, state) => const SignUpPage(),
              ),
            ])
          ],
        ),
      ],
    );
  }
}
