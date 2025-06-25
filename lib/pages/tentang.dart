import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/paragraf_tentang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Tentang extends StatelessWidget {
  const Tentang({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Aplikasi EconoMate',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),

                    const Gap(10),

                    SvgPicture.asset(
                      'assets/svgs/logo.svg',
                      height: 108,
                      width: 108,
                      colorFilter: ColorFilter.mode(
                        ColorConstant.birumuda,
                        BlendMode.srcIn,
                      ),
                    ),

                    const Gap(10),

                    ParagrafTentang(text: 'Halo, senang bisa menyapa Anda melalui halaman ini!',),
                    ParagrafTentang(text: 'Terima kasih telah memilih EconoMate sebagai teman setia dalam mengelola keuangan Anda.',),
                    ParagrafTentang(text: 'Di era digital yang serba cepat, kami memahami pentingnya kemudahan dalam mencatat pemasukan dan pengeluaran, serta mengatur keuangan dengan lebih cerdas. Itulah mengapa EconoMate hadir dengan fitur-fitur yang dirancang untuk membantu Anda mengendalikan finansial dengan lebih efisien.',),
                    ParagrafTentang(text: 'Dari pencatatan transaksi harian, pengelolaan modal untuk shopping, hingga fitur split bill yang memudahkan berbagi tagihan dengan teman, semuanya kami hadirkan dalam satu aplikasi dengan tampilan yang intuitif dan keamanan yang terjamin.',),
                    ParagrafTentang(text: 'Membangun EconoMate adalah perjalanan yang luar biasa, dan kini kami bangga bisa menghadirkannya untuk Anda. Saatnya mengelola keuangan dengan lebih cerdas dan praktis. Live smarter, spend wiser with EconoMate!',),
                    ParagrafTentang(text: 'Terus gunakan aplikasi ini dan nantikan inovasi kami selanjutnya!',),
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
