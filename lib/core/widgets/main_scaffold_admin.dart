import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffoldAdmin extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffoldAdmin({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF0),
      body: Row(
        children: [
          Container(
            width: 260,
            color: const Color(0xFFF2EFE5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nina's Kitchen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF8B4513))),
                      Text("Admin Terminal", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                _SidebarItem(
                  icon: Icons.dashboard,
                  label: "Dashboard",
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => _goBranch(0),
                ),
                _SidebarItem(
                  icon: Icons.restaurant_menu,
                  label: "Product Catalog",
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () => _goBranch(1),
                ),
                _SidebarItem(
                  icon: Icons.receipt_long,
                  label: "Order Management",
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: () => _goBranch(2),
                ),
                _SidebarItem(
                  icon: Icons.analytics,
                  label: "Kitchen Analytics",
                  isSelected: navigationShell.currentIndex == 3,
                  onTap: () => _goBranch(3),
                ),
                const Spacer(),
                const Divider(),
                _SidebarItem(icon: Icons.settings, label: "System Settings", isSelected: false, onTap: () {}),
                _SidebarItem(icon: Icons.logout, label: "Logout", isSelected: false, onTap: () {}),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }

  void _goBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }
}


class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Menggunakan warna cokelat primary dari tema kamu
    const primaryColor = Color(0xFF8B4513); 

    // Logika warna background (Animasi Hover)
    final bgColor = widget.isSelected
        ? primaryColor.withOpacity(0.15) // Warna saat menu aktif
        : isHovered
            ? primaryColor.withOpacity(0.05) // Warna samar saat di-hover
            : Colors.transparent; // Transparan saat diam

    // Logika warna ikon & teks
    final contentColor = widget.isSelected
        ? primaryColor
        : isHovered
            ? primaryColor.withOpacity(0.8)
            : Colors.grey.shade700;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      // MouseRegion untuk mendeteksi kursor (sangat penting untuk Web/Desktop)
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        // Material & InkWell untuk animasi klik (Ripple effect)
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            splashColor: primaryColor.withOpacity(0.2), // Warna cipratan saat diklik
            highlightColor: Colors.transparent,
            child: AnimatedContainer(
              // Durasi animasi background saat di-hover
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon, 
                    color: contentColor, 
                    size: 22,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: contentColor,
                      fontSize: 14,
                      // Font lebih tebal sedikit kalau sedang dipilih
                      fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}