import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSubmitOption extends StatelessWidget {
  const ButtonSubmitOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: ColorConstant.birumuda,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Buat Transaksi',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorConstant.putih,
          ),
        ),
      ),
    );
  }
}
