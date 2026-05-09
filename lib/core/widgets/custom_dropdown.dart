import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value; // Nilai yang sedang dipilih (bisa null)
  final List<String> items; // Daftar pilihan kategori
  final ValueChanged<String?> onChanged; // Aksi saat item dipilih
  final IconData? prefixIcon;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Label Teks
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50), // Warna gelap yang sama
          ),
        ),
        const SizedBox(height: 8),

        // 2. Dropdown Form Field
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          validator: validator,
          // Icon panah bawah kustom agar warnanya senada
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF6B5B49),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF8C7E6A)),
            
            // Icon Kiri (Prefix)
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: const Color(0xFF6B5B49))
                : null,
                
            filled: true,
            fillColor: const Color(0xFFEBE6D8), // Warna cream
            
            // Styling kotak agar sama dengan textfield
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF9E4B05), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          
          // Mengubah list string (items) menjadi bentuk Dropdown Menu
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2C3E50), // Warna teks item
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}