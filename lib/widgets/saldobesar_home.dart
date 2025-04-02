import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SaldobesarHome extends StatelessWidget{
  final String type;
  final String nominal;

  const SaldobesarHome({super.key, required this.type, required this.nominal});

  String formatMoney(String amount) {
    double value = double.tryParse(amount) ?? 0.0;

    final numberFormat = NumberFormat('#,###', 'id_ID');
    return numberFormat.format(value);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Saldo',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: ColorConstant.putih
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rp',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: ColorConstant.putih
              ),
            ),

            const Gap(5),

            Text(formatMoney(nominal),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: ColorConstant.putih
              ),
            )
          ],
        ),
      ],
    );
  }
}