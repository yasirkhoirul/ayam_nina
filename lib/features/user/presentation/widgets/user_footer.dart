import 'package:flutter/material.dart';

class UserFooter extends StatelessWidget {
  final bool isDesktop;

  const UserFooter({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(24),
        color: const Color(0xFFF2EFE5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Kedai Ayam Nina", style: TextStyle(fontWeight: FontWeight.bold)),
            if (isDesktop)
              const Row(
                children: [
                  Text("PRIVACY POLICY", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(width: 16),
                  Text("TERMS OF SERVICE", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(width: 16),
                  Text("CONTACT US", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            const Text("© 2024 KEDAI AYAM NINA", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
