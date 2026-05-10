import 'package:flutter/material.dart';

class UserFooter extends StatelessWidget {
  final bool isDesktop;

  const UserFooter({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: const Color(0xFFF2EFE5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Kedai Ayam Nina", style: TextStyle(fontWeight: FontWeight.bold)),
          
          const Text("© 2023 KEDAI AYAM NINA", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
