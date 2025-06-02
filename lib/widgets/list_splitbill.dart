import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListSplitbill extends StatelessWidget {
  final String isName;
  final String isDate;
  final double isNominal;
  final VoidCallback onDeletePressed;

  const ListSplitbill({
    super.key,
    required this.isName,
    required this.isDate,
    required this.isNominal,
    required this.onDeletePressed,
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
              subtitle: Text(
                isDate,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.abu,
                ),
              ),
              trailing: SizedBox(
                width: 210,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        Row(
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
                        const Gap(4),
                        GestureDetector(
                          onTap: onDeletePressed,
                          child: Container(
                            height: 28,
                            width: 70,
                            decoration: BoxDecoration(
                              color: ColorConstant.birumuda,
                              borderRadius: BorderRadius.all(Radius.circular(6))
                            ),
                            child: Center(
                              child: Text('Lunas',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.putih
                                  ),
                                ),
                            ),
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