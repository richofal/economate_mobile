import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSignin extends StatelessWidget {
  final String buttonText;

  const ButtonSignin({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: ColorConstant.birumuda,
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        minimumSize: Size(170, 42),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Color(0xFFFBFBFB)
          )
        ),
    );
  }
}