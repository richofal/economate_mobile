import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TextfieldPassword extends StatefulWidget {
  final TextEditingController controller;
  const TextfieldPassword({super.key, required this.controller});

  @override
  State<TextfieldPassword> createState() => _TextfieldPasswordState();
}

class _TextfieldPasswordState extends State<TextfieldPassword> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthenticationProvider>(context);
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Stack untuk menumpuk Container lingkaran di depan TextField
          Stack(
            clipBehavior:
                Clip.none, // Membuat agar lingkaran bisa melampaui batas Row
            children: [
              Container(
                height: 42,
                width: 300, // Menentukan lebar TextField
                padding: const EdgeInsets.only(left: 70),
                decoration: BoxDecoration(
                  color: ColorConstant.putih,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.birushadow,
                      spreadRadius: 1,
                      blurRadius: 7,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 70,
                child: SizedBox(
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: widget.controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: obscureText,
                        obscuringCharacter: "*",
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "Password tidak boleh kosong";
                          } else if (value.trim().length < 8) {
                            return "Password minimal terdiri dari 8 karakter";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          loadAuth.enteredPassword = value!;
                        },
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorConstant.abu,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: ColorConstant.abu,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Column(
                              children: [
                                SvgPicture.asset('assets/svgs/eyesopen.svg'),
                                const Gap(5)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Container lingkaran yang ditumpuk di depan TextField
              Positioned(
                top: -5, // Menempatkan lingkaran sedikit di atas
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
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/password.svg',
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
