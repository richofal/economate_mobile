import 'package:economate_mobile/widgets/background_home.dart';
import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/fitur_home.dart';
import 'package:economate_mobile/widgets/listhistory.dart';
import 'package:economate_mobile/widgets/saldobesar_home.dart';
import 'package:economate_mobile/widgets/saldokecil_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class History extends StatelessWidget{
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.putihbiru,
        ),
        child: Column(
          children: [
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
                      color: ColorConstant.birushadow,
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
                  ],
                )
              ),
            )
          ],
        ),
      )
    );
  }

}