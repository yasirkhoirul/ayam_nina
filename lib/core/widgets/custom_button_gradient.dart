import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final VoidCallback? onTap; // Jika null, tombol otomatis menjadi tidak bisa diklik (disabled)

  const CustomGradientButton({
    super.key,
    required this.text,
    this.leadingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onTap != null;

    return Container(
      width: double.infinity, // Mengisi lebar penuh, bisa dihapus jika ingin menyesuaikan isi
      height: 50, // Tinggi standar agar proporsional
      decoration: BoxDecoration(
        // Bentuk melengkung (pill shape)
        borderRadius: BorderRadius.circular(50),
        
        // Gradient dari Primary ke Secondary
        gradient: LinearGradient(
          colors: isEnabled
              ? [
                  colorScheme.primary,
                  colorScheme.secondary,
                ]
              // Warna abu-abu jika tombol di-set tidak bisa diklik (disabled)
              : [
                  Colors.grey.shade400,
                  Colors.grey.shade300,
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        
        // Bayangan tipis agar tombol lebih hidup (opsional)
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent, // Penting: agar gradient di belakangnya terlihat
        child: InkWell(
          borderRadius: BorderRadius.circular(50), // Menyesuaikan lengkungan luar
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menampilkan Icon jika diset
                if (leadingIcon != null) ...[
                  Icon(
                    leadingIcon,
                    color: colorScheme.onPrimary, // Warna icon onPrimary
                    size: 20,
                  ),
                  const SizedBox(width: 8), // Jarak icon ke teks
                ],
                
                // Teks Tombol
                Text(
                  text,
                  style: TextStyle(
                    color: colorScheme.onPrimary, // Warna teks onPrimary
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}