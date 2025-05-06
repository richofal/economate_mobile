import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/background_profile.dart';
import 'package:economate_mobile/widgets/label_profile.dart';
import 'package:economate_mobile/widgets/textview_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BackgroundProfile(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Gap(70),
                    Text(
                      'Taraka',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.putih,
                      ),
                    ),
                    const Gap(12),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.birushadow,
                            spreadRadius: 1,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          height: 150,
                          width: 150,
                          color: ColorConstant.putih,
                          child: SvgPicture.asset(
                            'assets/svgs/logo.svg',
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(
                              ColorConstant.birumuda,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),

                    LabelProfile(isLabel: 'Profil ku'),

                    TextviewProfile(
                      isIcon: 'nama',
                      isText: 'Muhammad Herjuna Taraka',
                    ),

                    const Gap(2),

                    LabelProfile(isLabel: 'Pengaturan Akun'),

                    // TextviewProfile(isIcon: 'akun', isText: 'Akun ku')
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                          },
                          child: Container(
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
                                  SvgPicture.asset(
                                    'assets/svgs/akun.svg',
                                    width: 26,
                                    fit: BoxFit.contain,
                                  ),
                                  const Gap(10),
                                  Text(
                                    'Akun ku',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.abu,
                                    ),
                                  ),
                                  Spacer(),
                                  SvgPicture.asset(
                                    'assets/svgs/arrowstroke.svg',
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(8),
                      ],
                    ),
                    TextviewProfile(isIcon: 'dompet', isText: 'Dompet ku'),
                    TextviewProfile(isIcon: 'kunci', isText: 'Kunci Aplikasi'),

                    const Gap(2),

                    LabelProfile(isLabel: 'Pengaturan Aplikasi'),

                    TextviewProfile(isIcon: 'bahasa', isText: 'Bahasa'),
                    TextviewProfile(isIcon: 'tampilan', isText: 'Tampilan'),

                    const Gap(2),

                    LabelProfile(isLabel: 'Bantuan'),

                    TextviewProfile(isIcon: 'tentang', isText: 'Tentang kami'),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/back.svg',
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigator.popUntil(context, (route) => route.isFirst);