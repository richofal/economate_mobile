import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSignin extends StatelessWidget {
  const ButtonSignin({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: ColorConstant.birumuda,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50)
      ),
      child: Text(
        'Sign in',
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFFFBFBFB)
          )
        ),
    );
  }
}