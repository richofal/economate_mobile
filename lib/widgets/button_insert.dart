import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonInsert extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final Color? backgroundColor; // Tambahkan parameter untuk warna background
  final Color? textColor; // Tambahkan parameter untuk warna teks
  final double? width; // Tambahkan parameter untuk lebar custom
  final IconData? icon; // Tambahkan parameter untuk ikon

  const ButtonInsert({
    super.key,
    required this.onPressed,
    this.text = 'Simpan',
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 50,
        width: width ?? double.infinity, // Gunakan width jika ada, else infinity
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isLoading 
              ? Colors.grey 
              : backgroundColor ?? ColorConstant.birumuda, // Gunakan custom color jika ada
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.birushadow,
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) // Tampilkan ikon jika ada
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(icon, size: 20, color: textColor ?? ColorConstant.putih),
                      ),
                    Text(
                      text,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor ?? ColorConstant.putih, // Gunakan custom color jika ada
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}