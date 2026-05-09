import 'package:flutter/material.dart';

class CustomTrendChip extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomTrendChip({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Ambil color scheme dari tema
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // mainAxisSize: MainAxisSize.min pada Row butuh ini agar padding bekerja baik
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        // Background putih transparan agar menyatu dengan latar belakang card
        color: colorScheme.onSecondary.withOpacity(0.2), 
        borderRadius: BorderRadius.circular(50.0), // Bentuk pill melengkung
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Penting: Lebar menyesuaikan isi
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ikon menggunakan warna onSecondary (Putih)
          Icon(
            icon,
            color: colorScheme.onSecondary, 
            size: 16.0, // Ukuran disesuaikan agar proporsional
          ),
          const SizedBox(width: 6.0), // Jarak antara ikon dan teks
          
          // Teks menggunakan warna onSecondary (Putih)
          Text(
            text,
            style: TextStyle(
              color: colorScheme.onSecondary,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}