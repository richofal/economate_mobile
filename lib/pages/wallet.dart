import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/saldobesar_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';

class Wallet extends StatelessWidget{
  const Wallet({super.key});

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
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SaldobesarHome(type: 'Saldo', nominal: '27141120')
                    ],
                  ),
                ),

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
                  child: Column(
                    children: [
                      ListView(
                        children: [
                          ListTile(
                              title: Text('Bank Mandiri',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.birumuda
                                ),
                              ),
                              trailing: Text('100.000'),
                            ),
                        ],
                      ),
                    ],
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