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
                        Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              dense: true,
                              title: Text('ShopeePay',
                                style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.hitam
                                ),
                              ),
                              trailing: SizedBox(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Rp',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.hitam
                                      ),
                                    ),
                                    Text('9.999.900.000',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.hitam
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),

                            Divider(
                              thickness: 1.2,
                              color: ColorConstant.abu,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              dense: true,
                              title: Text('Bank Mandiri',
                                style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.hitam
                                ),
                              ),
                              trailing: SizedBox(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Rp',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.hitam
                                      ),
                                    ),
                                    Text('9.999.900.000',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.hitam
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),

                            Divider(
                              thickness: 1.2,
                              color: ColorConstant.abu,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              dense: true,
                              title: Text('GoPay',
                                style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.hitam
                                ),
                              ),
                              trailing: SizedBox(
                                width: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Rp',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.hitam
                                      ),
                                    ),
                                    Text('9.999.900.000',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.hitam
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),

                            Divider(
                              thickness: 1.2,
                              color: ColorConstant.abu,
                            ),
                          ],
                        ),
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