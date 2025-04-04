import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterHistory extends StatelessWidget{
  final String isLabel;
  final int isWidth;

  const FilterHistory({super.key, required this.isLabel, required this.isWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 28,
          width: 136,
          decoration: BoxDecoration(
            color: ColorConstant.putih,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.birushadow,
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: Padding(padding: EdgeInsets.only(left: 10, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pengeluaran',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.birumuda,
                  ),
                ),

                SvgPicture.asset('assets/svgs/arrowsolid.svg',
                  height: 9,
                  width: 9,
                )
              ],
            ),
          )
        ),
      ],
    );
  }
}