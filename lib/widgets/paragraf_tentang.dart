import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ParagrafTentang extends StatelessWidget {
  final String text;
  const ParagrafTentang({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 360,
      ), // Atur lebar maksimal
      child: Column(
        children: [
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ColorConstant.abu,
            ),
            softWrap: true, // Aktifkan turun baris otomatis
          ),
          const Gap(14)
        ],
      ),
    );
  }
}
