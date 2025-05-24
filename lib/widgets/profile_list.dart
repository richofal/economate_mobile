import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileList extends StatelessWidget {
  final String isIcon;
  final String isText;
  final Widget isPage;

  const ProfileList({super.key, required this.isIcon, required this.isText, required this.isPage});

  String iconSource(String name){
    String icon = name.replaceAll(' ', '');
    return "assets/svgs/${icon.toLowerCase()}.svg";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            // await FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context) => isPage));
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstant.putih,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.birushadow,
                  spreadRadius: 1,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    iconSource(isIcon),
                    width: 26,
                    fit: BoxFit.contain,
                  ),
                  const Gap(10),
                  Text(
                    isText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.abu,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/svgs/arrowstroke.svg',
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(8),
      ],
    );
  }
}

// Navigator.popUntil(context, (route) => route.isFirst);