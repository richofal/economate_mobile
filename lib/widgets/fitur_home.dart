import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class FiturHome extends StatelessWidget{
  final String type;

  const FiturHome({super.key, required this.type});

  String iconSource(String name){
    String icon = name.replaceAll(' ', '');
    return "assets/svgs/${icon.toLowerCase()}.svg";
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60,
      width: 120,
      decoration: BoxDecoration(
        color: ColorConstant.putih,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xB1C5BAFF),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(4),

          SvgPicture.asset(iconSource(type),
            height: 30,
            width: 30,            
          ),

          const Gap(1),

          Text(type,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ColorConstant.birumuda,
            ),
          )
        ],
      ),
    );
  }
}