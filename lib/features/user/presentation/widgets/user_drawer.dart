import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kedai_ayam_nina/router/router.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;

    Color getColor(String path) {
      return currentPath == path ? const Color(0xFF8B4513) : Colors.black87;
    }

    return Drawer(
      backgroundColor: const Color(0xFFFDFBF0),
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFF2EFE5),
            ),
            child: Center(
              child: Text(
                "Kedai Ayam Nina",
                style: TextStyle(
                  color: Color(0xFF8B4513),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: getColor(MyRoute.home.path)),
            title: Text("Home", style: TextStyle(color: getColor(MyRoute.home.path), fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              context.goNamed(MyRoute.home.name);
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu, color: getColor(MyRoute.catalog.path)),
            title: Text("Menu", style: TextStyle(color: getColor(MyRoute.catalog.path), fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              context.goNamed(MyRoute.catalog.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.black87),
            title: const Text("Gallery", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: getColor(MyRoute.about.path)),
            title: Text("About", style: TextStyle(color: getColor(MyRoute.about.path), fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              context.goNamed(MyRoute.about.name);
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail, color: getColor(MyRoute.contactUs.path)),
            title: Text("Contact Us", style: TextStyle(color: getColor(MyRoute.contactUs.path), fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              context.goNamed(MyRoute.contactUs.name);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.login, color: Color(0xFF8B4513)),
            title: const Text("Admin Login", style: TextStyle(color: Color(0xFF8B4513), fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              context.goNamed(MyRoute.login.name);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
