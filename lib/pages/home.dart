import 'package:economate_mobile/widgets/background_home.dart';
import 'package:economate_mobile/constants/color_constant.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
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

            Row(
              children: [
                
              ],
            )
          ],
        ),

      ),
    );
  }
}