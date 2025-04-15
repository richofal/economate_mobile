import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/list_bulan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstant.putihbiru,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Analysis',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),

                    const Gap(10),

                    Image.asset('assets/images/barchart.png'), // Mohon maaf Bu/Pak ini memang belum jadi karna keterbatasan waktu

                    const Gap(10),

                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.putih,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.hitamshadow,
                              spreadRadius: 1,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  ListBulan(isMonth: 'Januari', isPemasukan: 780000, persenPemasukan: '52%', isPengeluaran: 720000, persenPengeluaran: '48%'),
                                  ListBulan(isMonth: 'Februari', isPemasukan: 820000, persenPemasukan: '60%', isPengeluaran: 680000, persenPengeluaran: '40%'),
                                  ListBulan(isMonth: 'Maret', isPemasukan: 1040000, persenPemasukan: '68%', isPengeluaran: 480000, persenPengeluaran: '32%'),
                                  ListBulan(isMonth: 'April', isPemasukan: 1320000, persenPemasukan: '70%', isPengeluaran: 640000, persenPengeluaran: '30%'),
                                  ListBulan(isMonth: 'Mei', isPemasukan: 650000, persenPemasukan: '72%', isPengeluaran: 380000, persenPengeluaran: '28%'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/back.svg',
                    height: 30,
                    width: 30,
                    colorFilter: ColorFilter.mode(
                      ColorConstant.birumuda,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
