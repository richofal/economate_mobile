import 'package:economate_mobile/widgets/background_home.dart';
import 'package:economate_mobile/constants/color_constant.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
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

            Column(
              children: [
                Text('Saldo',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.putih
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rp',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.putih
                      ),
                    ),

                    const Gap(5),

                    Text('20.274.714',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.putih
                      ),
                    )
                  ],
                ),

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
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        SvgPicture.asset('assets/svgs/panahatas.svg',
                          height: 40,
                          width: 40,
                        ),
                    
                        

                        SizedBox(
                          width: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Pemasukan',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.putih
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Rp',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstant.putih
                                        ),
                                      ),

                                      const Gap(3),

                                      Text('14.700.000',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstant.putih
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        Container(
                          height: 50,
                          width: 1.5,
                          decoration: BoxDecoration(
                            color: ColorConstant.putih
                          ),
                        ),

                        SizedBox(
                          width: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Pengeluaran',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.putih
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Rp',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstant.putih
                                        ),
                                      ),

                                      const Gap(3),
                                      
                                      Text('11.400.000',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstant.putih
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                        

                        SvgPicture.asset('assets/svgs/panahbawah.svg',
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}