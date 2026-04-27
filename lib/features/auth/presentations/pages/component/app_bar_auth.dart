import 'package:flutter/material.dart';
import 'package:kedai_ayam_nina/core/assets.dart';

class AppBarAuth extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const AppBarAuth({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset(Assets.logoC1),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}