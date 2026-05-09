import 'package:flutter/material.dart';

class CardGradient extends StatelessWidget {
  final Widget child;
  final IconData? backgroundIcon; // Tambahkan parameter opsional untuk icon

  const CardGradient({
    super.key, 
    required this.child,
    this.backgroundIcon, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Dekorasi utama (Warna & Radius) tetap di Container terluar
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // Jika di gambar desain kelihatannya lebih besar, misal 24
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary, // Saya hilangkan opacity agar warnanya solid seperti di gambar
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      
      // Gunakan ClipRRect agar icon background yang kebesaran tidak keluar dari batas card
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // LAYER BAWAH: Background Icon (Hanya tampil jika backgroundIcon diisi)
            if (backgroundIcon != null)
              Positioned(
                right: -20, // Geser ke kanan agar terpotong (sesuaikan nilainya)
                bottom: -60, // Geser ke bawah agar terpotong (sesuaikan nilainya)
                child: Opacity(
                  opacity: 0.15, // Buat iconnya transparan/samar-samar
                  child: Icon(
                    backgroundIcon,
                    size: 150, // Ukuran icon sangat besar
                    color: Colors.white, // Warna putih transparan biasanya cocok untuk watermark
                  ),
                ),
              ),

            // LAYER ATAS: Konten Utama (Teks dll)
            // Tambahkan padding di sini agar isi tidak menempel ke tepi
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}