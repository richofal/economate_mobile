import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonSignin extends StatelessWidget {
  const ButtonSignin({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      
      onPressed: () {},
      
      child: Text(
        'Sign in',
        style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          )
        ),
    );
  }
}