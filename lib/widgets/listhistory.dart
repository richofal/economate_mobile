import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/constants/transaction_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListHistory extends StatelessWidget {
  final String category;
  final String title;
  final DateTime date;
  final double amount;
  final bool isIncome;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ListHistory({
    super.key,
    required this.category,
    required this.title,
    required this.date,
    required this.amount,
    required this.isIncome,
    this.onTap,
    this.onLongPress,
  });

  // Map category to icon
  String _getIconPath(String category) {
    // Use predefined mapping from constants
    final iconName = category.toLowerCase();
    
    // Return the SVG asset path
    return "assets/svgs/"+iconName+".svg";
  }

  // Format currency with proper sign
  String _formatCurrency(double amount, bool isIncome) {
    final formatter = NumberFormat('#,###', 'id_ID');
    final formatted = formatter.format(amount.abs());
    return isIncome ? '+$formatted' : '-$formatted';
  }

  // Format date to display
  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              horizontalTitleGap: 10,
              minLeadingWidth: 42,
              dense: true,
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: ColorConstant.putihbiru.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    _getIconPath(category),
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      isIncome ? ColorConstant.birumuda : ColorConstant.merah,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.hitam,
                ),
              ),
              subtitle: Text(
                _formatDate(date),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.abu,
                ),
              ),
              trailing: Text(
                _formatCurrency(amount, isIncome),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isIncome ? ColorConstant.birumuda : ColorConstant.merah,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 1,
            height: 1,
            color: ColorConstant.abu,
          ),
        ],
      ),
    );
  }
}