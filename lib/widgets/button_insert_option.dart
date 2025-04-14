import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonInsertOption extends StatelessWidget {
  final String isLabel;
  
  const ButtonInsertOption({
    super.key, required this.isLabel
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.putih,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.birushadow,
                spreadRadius: 1,
                blurRadius: 6
              )
            ]
          ),
          child: Center(
            child: Text(
              isLabel,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorConstant.birumuda,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
