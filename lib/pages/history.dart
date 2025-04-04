import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/filter_history.dart';
import 'package:economate_mobile/widgets/listhistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';


class History extends StatelessWidget{
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.putihbiru,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('History',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.birumuda
                      ),
                    ),
                  ],
                ),

                const Gap(10),

                Row(
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
                ),

                const Gap(6),

                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FilterHistory(isLabel: 'Semua', isWidth: 150),
                    const Gap(6),
                    FilterHistory(isLabel: 'September', isWidth: 128),
                    const Gap(6),
                    FilterHistory(isLabel: '2025', isWidth: 80)
                  ],
                ),

                const Gap(6),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.putih,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.hitamshadow,
                          spreadRadius: 1,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(top: 6),
                      children: [
                        Listhistory(isIcon: 'makan', isTitle: 'Ramen', isDate: '11 Maret 2025', isNominal: -36000),
                        Listhistory(isIcon: 'ball', isTitle: 'Basket Angkatan', isDate: '11 Maret 2025', isNominal: -25000),
                        Listhistory(isIcon: 'paper', isTitle: 'Print laporan', isDate: '11 Maret 2025', isNominal: -6000),
                        Listhistory(isIcon: 'cash', isTitle: 'Saku bulanan', isDate: '11 Maret 2025', isNominal: 300000),
                        Listhistory(isIcon: 'makan', isTitle: 'Ciput', isDate: '11 Maret 2025', isNominal: -11000),
                        Listhistory(isIcon: 'paper', isTitle: 'Kertas folio', isDate: '11 Maret 2025', isNominal: -10000),
                        Listhistory(isIcon: 'makan', isTitle: 'Indomie', isDate: '11 Maret 2025', isNominal: -12000),
                        Listhistory(isIcon: 'makan', isTitle: 'Somay', isDate: '11 Maret 2025', isNominal: -16000),
                        Listhistory(isIcon: 'makan', isTitle: 'Chicken Katsu', isDate: '11 Maret 2025', isNominal: -13000),
                        Listhistory(isIcon: 'paper', isTitle: 'Bulpen dan stipo', isDate: '11 Maret 2025', isNominal: -16000),
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}