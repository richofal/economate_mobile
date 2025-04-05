import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:economate_mobile/constants/color_constant.dart';
import 'package:google_fonts/google_fonts.dart';


class LabelProfile extends StatelessWidget{
  final String isLabel;

  const LabelProfile({super.key, required this.isLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Profil',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorConstant.hitam,
              ),
            )
          ],
        ),
        
        const Gap(5),
      ],
    );
  }
}