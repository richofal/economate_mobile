import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Listhistory extends StatelessWidget{
  final String isIcon;
  final String isTitle;
  final String isDate;
  final double isNominal;

  const Listhistory({super.key, required this.isIcon, required this.isTitle, required this.isDate, required this.isNominal});

  String iconSource(String name){
    String icon = name.replaceAll(' ', '');
    return "assets/svgs/${icon.toLowerCase()}.svg";
  }

  String formatMoney(double amount) {
    final numberFormat = NumberFormat('#,###', 'id_ID');
    return numberFormat.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            horizontalTitleGap: 10,
            dense: true,
            
            leading: SvgPicture.asset(iconSource(isIcon),
              height: 42,
              width: 42,
            ),
            title: Text(isTitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: ColorConstant.hitam
              ),
            ),
            subtitle: Text(isDate,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorConstant.abu
              ),
            ),
            trailing: Text(formatMoney(isNominal),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isNominal < 0 ? ColorConstant.merah : ColorConstant.birumuda
              ),
            ),
          ),

          Divider(
            thickness: 1,
            color: ColorConstant.abu,
          ),
        ],
      ),
    );
  }
}