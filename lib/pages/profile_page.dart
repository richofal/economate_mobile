import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/pages/alamat.dart';
import 'package:economate_mobile/pages/gender.dart';
import 'package:economate_mobile/pages/profile.dart';
import 'package:economate_mobile/pages/telpon.dart';
import 'package:economate_mobile/pages/tentang.dart';
import 'package:economate_mobile/pages/wallet_screen.dart';
import 'package:economate_mobile/widgets/background_profile.dart';
import 'package:economate_mobile/widgets/label_profile.dart';
import 'package:economate_mobile/widgets/profile_list.dart';
import 'package:economate_mobile/widgets/textview_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/pages/akun.dart';

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
                      Supabase.instance.client.auth.currentUser?.userMetadata?['username']?.toString() ?? 'Username',
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

                    ProfileList(isIcon: 'nama', isText: 'Muhammad Herjuna Taraka', isPage: Profile()),
                    ProfileList(isIcon: 'gender', isText: 'Laki-laki', isPage: Gender()),
                    ProfileList(isIcon: 'location', isText: 'Indonesia, Jawa timur', isPage: Alamat(),),

                    const Gap(2),

                    LabelProfile(isLabel: 'Pengaturan Akun'),

                    ProfileList(isIcon: 'akun', isText: 'Akun ku', isPage: Akun()),
                    ProfileList(isIcon: 'dompet', isText: 'Dompet ku', isPage: WalletScreen()),
                    ProfileList(isIcon: 'telp', isText: '+62 812 3456 7890', isPage: Telpon(),),

                    const Gap(2),

                    LabelProfile(isLabel: 'Bantuan'),
                    ProfileList(isIcon: 'tentang', isText: 'Tentang kami', isPage: Tentang()),
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
