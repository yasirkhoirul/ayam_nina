// Custom Grid Item Widget
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kedai_ayam_nina/features/produk/domain/entities/product.dart';

class ProductGridItem extends StatefulWidget {
  final Product product; // Sesuaikan dengan tipe model Product kamu
  final VoidCallback onDelete;
  final VoidCallback? onTapCard; // TAMBAHAN: Parameter aksi saat seluruh card diklik

  const ProductGridItem({
    super.key,
    required this.product,
    required this.onDelete,
    this.onTapCard, // Bisa dikosongkan jika belum butuh
  });

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Warna saat di-hover dan warna default
    final hoverColor = theme.colorScheme.secondary; 
    final defaultBgColor = const Color(0xFFF5F2E8); // Warna cream terang sesuai desain

    // Penyesuaian warna teks berdasarkan state hover
    final titleColor = isHovered ? theme.colorScheme.onSecondary : Colors.black87;
    // Warna deskripsi sedikit lebih redup dari judul
    final descColor = isHovered ? theme.colorScheme.onSecondary.withOpacity(0.85) : Colors.grey[600]; 
    final priceColor = isHovered ? theme.colorScheme.onSecondary : const Color(0xFFD66B0D);
    final iconActionColor = isHovered ? theme.colorScheme.onSecondary : Colors.grey[700];

    // TAMBAHAN: GestureDetector untuk membuat seluruh card clickable
    return GestureDetector(
      onTap: widget.onTapCard, // Panggil aksi klik card di sini
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // TAMBAHAN: Kursor berubah jadi jari telunjuk
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Disesuaikan agar lebih gesit & natural
          curve: Curves.easeOut, // Curve yang cocok untuk efek pop-up
          
          // --- KUNCI ANIMASI TERANGKAT ---
          // Jika isHovered true, geser sumbu Y sebanyak -10 pixel (naik). Jika false, kembali ke 0.
          transform: Matrix4.translationValues(0, isHovered ? -10.0 : 0, 0),
          
          decoration: BoxDecoration(
            color: isHovered ? hoverColor : defaultBgColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: hoverColor.withOpacity(0.4), // Opacity shadow sedikit dinaikkan agar efek terangkat lebih nyata
                      blurRadius: 20, // Blur dilebarkan
                      offset: const Offset(0, 12), // Shadow digeser lebih ke bawah
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BAGIAN ATAS: Gambar Produk
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(24)),
                child: Container(
                  height: 180, // Tinggi gambar di dalam card
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: widget.product.imageUrl.isNotEmpty &&
                          widget.product.imageUrl.first.startsWith('http')
                      ? Image.network(
                          widget.product.imageUrl.first,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Icon(Icons.fastfood, color: Colors.grey, size: 50),
                        ),
                ),
              ),
              
              // BAGIAN BAWAH: Informasi & Aksi
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama Produk
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: titleColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6), // Jarak tipis ke deskripsi
                      
                      // --- SHORT DETAIL / DESKRIPSI ---
                      Text(
                        widget.product.shortDescription, 
                        style: TextStyle(
                          fontSize: 12,
                          color: descColor,
                          height: 1.4, 
                        ),
                        maxLines: 2, 
                        overflow: TextOverflow.ellipsis, 
                      ),
                      
                      const Spacer(),
                      
                      // Harga & Tombol Edit/Delete
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Rp ${widget.product.price.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: priceColor,
                            ),
                          ),
                          
                          // Action Buttons (Edit & Delete)
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: iconActionColor, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () => context.go('/admin/catalog/mutation?id=${widget.product.id}'),
                                tooltip: "Edit Product",
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                icon: Icon(Icons.delete, color: isHovered ? theme.colorScheme.onSecondary : Colors.red, size: 20),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: widget.onDelete,
                                tooltip: "Delete Product",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}