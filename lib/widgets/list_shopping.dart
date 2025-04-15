import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListShopping extends StatelessWidget {
  final String isName;
  final double isNominal;

  const ListShopping({
    super.key,
    required this.isName,
    required this.isNominal,
  });

  String formatMoney(double amount) {
    final numberFormat = NumberFormat('#,###', 'id_ID');
    String result = numberFormat.format(amount);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.putih,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.hitamshadow,
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              horizontalTitleGap: 10,
              dense: true,
        
              title: Text(
                isName,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.hitam,
                ),
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rp',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.hitam,
                      ),
                    ),
                    const Gap(1),
                    Text(
                      formatMoney(isNominal),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: ColorConstant.hitam,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const Gap(10),
      ],
    );
  }
}
