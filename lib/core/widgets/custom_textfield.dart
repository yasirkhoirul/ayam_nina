import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final bool obscureText;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  
  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.obscureText = false,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onSuffixTap,
  });

  CustomInputField.number({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.obscureText = false,
    this.onSuffixTap,
  }) : keyboardType = TextInputType.number, inputFormatters = [FilteringTextInputFormatter.digitsOnly];

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
            color: Color(0xFF2C3E50), // Sesuaikan dengan warna teks gelapmu
          ),
        ),
        const SizedBox(height: 8), // Jarak antara label dan textfield
        
        // 2. Text Form Field
        TextFormField(
          obscureText: obscureText,
          inputFormatters: inputFormatters ?? [],
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly, // Berguna untuk input tanggal
          onTap: onTap, // Aksi ketika field ditekan
          validator: validator,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF8C7E6A)), // Warna abu-abu kecokelatan
    
            // Icon Kiri (Prefix)
            prefixIcon: prefixIcon != null 
                ? Icon(prefixIcon, color: const Color(0xFF6B5B49)) 
                : null,
                
            // Icon Kanan (Suffix)
            suffixIcon: suffixIcon != null 
                ? IconButton(
                    icon: Icon(suffixIcon, color: const Color(0xFF6B5B49)),
                    onPressed: onSuffixTap,
                  )
                : null,
                
            filled: true,
            fillColor: const Color(0xFFEBE6D8), // Warna latar cream sesuai gambar
            
            // Konfigurasi Border (Dibuat none agar mulus seperti gambar)
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF9E4B05), width: 1.5), // Garis saat diklik
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
        ),
      ],
    );
  }
}