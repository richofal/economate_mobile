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

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundHome(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hi, Taraka',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.putih,
                  ),
                ),

                SvgPicture.asset('assets/svgs/pfp.svg',
                  height: 35,
                  width: 35,
                )
              ],
            ),
            
            const Gap(20),

            SaldobesarHome(type: "Saldo", nominal: '271420110'),

            const Gap(20),

            Container(
              height: 64,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstant.birumuda,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x2B000000),
                    spreadRadius: 1,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      
                    SvgPicture.asset('assets/svgs/panahatas.svg',
                      height: 40,
                      width: 40,
                    ),
                        
                    SaldokecilHome(type: 'Pemasukan', nominal: '14720000'),

                    Container(
                      height: 50,
                      width: 1.5,
                      decoration: BoxDecoration(
                        color: ColorConstant.putih
                      ),
                    ),

                    SaldokecilHome(type: 'Pengeluaran', nominal: '11140000'),

                    SvgPicture.asset('assets/svgs/panahbawah.svg',
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              )
            ),

            const Gap(10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FiturHome(type: 'Analisa'),

                FiturHome(type: 'Split Bill'),

                FiturHome(type: 'Shopping'),
              ],
            ),

            const Gap(10),

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
      ),
    );
  }
}