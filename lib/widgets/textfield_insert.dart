import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldInsert extends StatelessWidget{
  final String isHint;

  const TextfieldInsert({super.key, required this.isHint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        color: ColorConstant.putih,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.birushadow,
            spreadRadius: 1,
            blurRadius: 8
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorConstant.hitam
              ),
              decoration: InputDecoration(
                hintText: isHint,
                hintStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.abu
                ),
                border: InputBorder.none
              ),
            ),
          ),
        ],
      )
    );
  }
}