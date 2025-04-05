import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Listwallet extends StatelessWidget{
  final String isLabel;
  final double isNominal;

  const Listwallet({super.key, required this.isLabel, required this.isNominal});

  String formatMoney(double amount) {
    final numberFormat = NumberFormat('#,###', 'id_ID');
    return numberFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          dense: true,
          title: Text(isLabel,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorConstant.hitam
            ),
          ),                    
          trailing: SizedBox(
            width: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rp',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.hitam
                  ),
                ),
                const Gap(1),
                Text(formatMoney(isNominal),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.hitam
                  ),
                ),
              ],
            ),
          )
        ),

        Divider(
          thickness: 1.2,
          color: ColorConstant.abu,
        ),
      ],
    );
  }
}