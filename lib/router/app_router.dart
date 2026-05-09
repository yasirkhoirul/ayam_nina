import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kedai_ayam_nina/core/widgets/main_scaffold_admin.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/component/main_scaffold_auth.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/login_page.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/sign_up_page.dart';
import 'package:kedai_ayam_nina/features/home/pages/home.dart';
import 'package:kedai_ayam_nina/features/produk/presentation/pages/product_catalog_page.dart';
import 'package:kedai_ayam_nina/features/produk/presentation/pages/product_mutation_page.dart';
import 'package:kedai_ayam_nina/features/transactions/presentations/pages/annual_growth_page.dart';
import 'package:kedai_ayam_nina/features/transactions/presentations/pages/transaction_mutation.dart';
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
                GoRoute(path: MyRoute.login.path, builder: (context, state) => LoginPage(onSignUp: (){
                  context.pushNamed(MyRoute.signup.name);
                })),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                name: MyRoute.signup.name,
                path: MyRoute.signup.path, builder: (context, state) => const SignUpPage()),
            ])
          ],
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => MainScaffoldAdmin(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(routes: [ GoRoute(path: '/admin/dashboard', builder: (context, state) => const Scaffold(body: Center(child: Text("Dashboard")))) ]),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: MyRoute.adminCatalog.path,
                  builder: (context, state) => const ProductCatalogPage(),
                  routes: [
                    GoRoute(
                      path: 'mutation',
                      builder: (context, state) => ProductMutationPage(productId: state.uri.queryParameters['id']), 
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(routes: [ GoRoute(path: '/admin/orders', builder: (context, state) => const TransactionMutation()) ]),
            StatefulShellBranch(routes: [ GoRoute(path: '/admin/analytics', builder: (context, state) => const AnnualGrowthPage()) ]),
          ],
        ),
      ],
    );
  }
}
