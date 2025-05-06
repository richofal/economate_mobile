import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/list_bulan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Akun extends StatelessWidget {
  const Akun({super.key});

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

                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConstant.putih,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.birushadow,
                            spreadRadius: 1,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12, right: 16),
                        child: Row(
                          children: [
                            const Gap(10),
                            Text(
                              'Muhammad Herjuna Taraka',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.abu,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              'assets/svgs/pensil.svg',
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.birumuda,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.hitamshadow,
                              spreadRadius: 1,
                              blurRadius: 7,
                            )
                          ]
                        ),
                        child: Center(
                          child: Text('Tambah Tagihan',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.putih
                            ),
                          ),
                        ),
                      ),
                    )
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
