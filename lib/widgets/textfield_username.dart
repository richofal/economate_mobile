import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldUsername extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;

  const TextfieldUsername({
    super.key, 
    required this.controller,
    this.validator,
    this.hintText = 'Username',
  });

  @override
  State<TextfieldUsername> createState() => _TextfieldUsernameState();
}

class _TextfieldUsernameState extends State<TextfieldUsername> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 42,
                width: 300,
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
                        validator: widget.validator ?? (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          if (value.length < 3) {
                            return 'Username minimal 3 karakter';
                          }
                          if (value.length > 20) {
                            return 'Username maksimal 20 karakter';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                            return 'Hanya boleh huruf, angka, dan underscore';
                          }
                          return null;
                        },
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorConstant.abu,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: ColorConstant.abu,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Column(
                              children: [
                                SvgPicture.asset('assets/svgs/eyesopen.svg',
                                    colorFilter: ColorFilter.mode(
                                        Colors.transparent, BlendMode.srcIn)),
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
              Positioned(
                top: -5,
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
                    'assets/svgs/username.svg', // Make sure you have this asset
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