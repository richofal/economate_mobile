import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/background_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundProfile(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Gap(70),
              Text('Taraka',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 30,
                  fontWeight:FontWeight.w600,
                  color: ColorConstant.putih
                ),
              ),
              const Gap(10),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.birushadow,
                      spreadRadius: 1,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    height: 150,
                    width: 150,
                    color: ColorConstant.putih,
                    child: SvgPicture.asset('assets/svgs/logo.svg',
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      )
    );
  }
}