import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldInsert extends StatelessWidget {
  final String isHint;
  final double isHeight;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;

  const TextfieldInsert({
    super.key, 
    required this.isHint, 
    this.isHeight = 50,
    this.controller,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isHeight,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        color: ColorConstant.putih,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.birushadow,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            validator: validator,
            maxLines: maxLines,
            maxLength: maxLength,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ColorConstant.hitam,
            ),
            decoration: InputDecoration(
              hintText: isHint,
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorConstant.abu,
              ),
              border: InputBorder.none,
              counterText: '', // Untuk menghilangkan counter jika maxLength digunakan
              contentPadding: EdgeInsets.zero, // Menyesuaikan padding
            ),
          ),
        ],
      ),
    );
  }
}