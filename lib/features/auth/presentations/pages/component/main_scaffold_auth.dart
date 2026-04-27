import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kedai_ayam_nina/features/auth/presentations/pages/component/app_bar_auth.dart';

class MainScaffoldAuth extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScaffoldAuth({super.key, required this.navigationShell});
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: const AppBarAuth(title: 'Auth'),
        body: navigationShell,
      );
    }
}