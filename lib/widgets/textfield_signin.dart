import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldSignin extends StatelessWidget{
  final String isLabel;

  const TextfieldSignin({super.key, required this.isLabel});

  @override
  Widget build(BuildContext context) {
    String iconName = isLabel.replaceAll(' ', '');
    String icons = "assets/svgs/${iconName.toLowerCase()}.svg";

    // TODO: implement build
    return SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Stack untuk menumpuk Container lingkaran di depan TextField
                  Stack(
                    clipBehavior: Clip.none,  // Membuat agar lingkaran bisa melampaui batas Row
                    children: [
                      Container(
                        height: 42,
                        width: 300, // Menentukan lebar TextField
                        padding: const EdgeInsets.only(left: 70),
                        decoration: BoxDecoration(
                          color: Color(0xFFFBFBFB),
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xB1C5BAFF),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: TextField(
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xFF767676),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          obscureText: true,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            hintText: isLabel,
                            hintStyle: GoogleFonts.plusJakartaSans(
                              color: Color(0xFF767676),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                          ),
                        ),
                      ),
                      // Container lingkaran yang ditumpuk di depan TextField
                      Positioned(
                        top: -5,   // Menempatkan lingkaran sedikit di atas
                        child: Container(
                          height: 52,
                          width: 52,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBFBFB),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xB1C5BAFF),
                                spreadRadius: 1,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            icons,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
  }
}  