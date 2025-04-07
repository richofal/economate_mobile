import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/listwallet.dart';
import 'package:economate_mobile/widgets/saldobesar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';

class Wallet extends StatelessWidget{
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: ColorConstant.birumuda,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset('')
          ],
        ),
      ),
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
                    Text('Wallet',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.birumuda
                      ),
                    ),
                  ],
                ),

                const Gap(10),

                Container(
                  height: 108,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstant.birumuda,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SaldobesarHome(type: 'Saldo', nominal: '27141120')
                    ],
                  ),
                ),

                const Gap(10),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorConstant.putih,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x2B000000),
                        spreadRadius: 1,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Padding(padding: EdgeInsets.only(left: 14, right: 14, bottom: 16),
                    child: Column(
                      children: [
                        Listwallet(isLabel: 'Bank Mandiri', isNominal: 4500000),
                        Listwallet(isLabel: 'Dana', isNominal: 100000),
                        Listwallet(isLabel: 'Bank BNI', isNominal: 500000),
                        Listwallet(isLabel: 'Gopay', isNominal: 40000),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}