import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SaldokecilHome extends StatelessWidget{
  final String type;
  final String nominal;

  const SaldokecilHome({super.key, required this.type, required this.nominal});

  String formatMoney(String amount) {
    double value = double.tryParse(amount) ?? 0.0;

    final numberFormat = NumberFormat('#,###', 'id_ID');
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(type,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
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
                      fontSize: 10,
                      fontWeight: FontWeight.w600,                        
                      color: ColorConstant.putih
                    ),
                  ),
                  
                  const Gap(2),

                  Text(formatMoney(nominal),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.putih
                    ),
                  )
                ],
              ),
            ],            
          )
        ],
      ),
    );
  }
}