import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterHistory extends StatelessWidget {
  final String isLabel;
  final double isWidth;
  final bool isActive;
  final VoidCallback onTap;

  const FilterHistory({
    super.key,
    required this.isLabel,
    required this.isWidth,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: isWidth,
        decoration: BoxDecoration(
          color: isActive ? ColorConstant.birumuda : ColorConstant.putih,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.hitamshadow,
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color:
                      isActive ? ColorConstant.putih : ColorConstant.birumuda,
                ),
              ),
              SvgPicture.asset(
                'assets/svgs/arrowsolid.svg',
                height: 9,
                width: 9,
                colorFilter: ColorFilter.mode(
                  isActive ? ColorConstant.putih : ColorConstant.birumuda,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
