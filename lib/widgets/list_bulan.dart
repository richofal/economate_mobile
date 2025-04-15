import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListBulan extends StatelessWidget {
  final String isMonth;
  final double isPemasukan;
  final String persenPemasukan;
  final double isPengeluaran;
  final String persenPengeluaran;

  const ListBulan({
    super.key, required this.isMonth, required this.isPemasukan, required this.persenPemasukan, required this.isPengeluaran, required this.persenPengeluaran,
  });

  String formatMoney(double amount) {
    final numberFormat = NumberFormat('#,###', 'id_ID');
    String result = numberFormat.format(amount);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isMonth,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ColorConstant.hitam,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pemasukan',
                        style:
                            GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.hitam,
                            ),
                      ),
                      const Gap(2),
                      Text(
                        persenPemasukan,
                        style:
                            GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.abu,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    formatMoney(isPemasukan),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.hitam,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pengeluaran',
                        style:
                            GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.hitam,
                            ),
                      ),
                      const Gap(2),
                      Text(
                        persenPengeluaran,
                        style:
                            GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.abu,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    formatMoney(isPengeluaran),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.hitam,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    
        Divider(thickness: 1, color: ColorConstant.abu),
    
        const Gap(4)
      ],
    );
  }
}
