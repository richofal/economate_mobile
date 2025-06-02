import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListCart extends StatelessWidget {
  final String isName;
  final double isQuantity;
  final double isPrice;

  const ListCart({
    super.key,
    required this.isName,
    required this.isQuantity,
    required this.isPrice,
  });

  String quantity(double amount) {
    int intAmount = amount.toInt();
    return '$intAmount'
        'x';
  }

  String formatMoney(double amount) {
    final numberFormat = NumberFormat('#,###', 'id_ID');
    String result = numberFormat.format(amount);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150, // Sesuaikan lebar sesuai kebutuhan
                    child: Text(
                      isName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.hitam,
                      ),
                      overflow:
                          TextOverflow
                              .ellipsis, // Menambahkan ".." jika teks dipotong
                      maxLines: 1, // Membatasi teks ke 1 baris
                    ),
                  ),
                  Text(
                    quantity(isQuantity),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.abu,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rp',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.hitam,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    formatMoney(isPrice),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: ColorConstant.hitam,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const Gap(12),
      ],
    );
  }
}
