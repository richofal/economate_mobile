import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:intl/intl.dart';

class SaldokecilHome extends StatelessWidget {
  final String type;
  final String nominal;
  final VoidCallback? onTap;
  final bool isIncome;

  const SaldokecilHome({
    super.key, 
    required this.type, 
    required this.nominal,
    this.onTap,
    this.isIncome = false,
  });

  String formatMoney(String amount) {
    double value = double.tryParse(amount) ?? 0.0;
    final numberFormat = NumberFormat('#,###', 'id_ID');
    return numberFormat.format(value);
  }

  @override
  Widget build(BuildContext context) {
    // Determine text color based on type
    final textColor = ColorConstant.putih;
    final amountColor = ColorConstant.putih;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  type,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                const Gap(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rp',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: amountColor,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      formatMoney(nominal),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: amountColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}