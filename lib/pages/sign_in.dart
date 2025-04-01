import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/button_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';

class SignInPage extends StatelessWidget {

  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F9FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(30),

              Text('EconoMate', 
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF089BFF)
                ),
              ),

              const Gap(10),

              Image.asset(
                'assets/images/logobiru.png',
                height: 90,
                width: 90,
              ),
              
              const Gap(10),

              Text('Selamat datang kembali!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF767676)
                ),
              ),

              const Gap(5),

              Text('Masukkan akun mu disini',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF767676)
                ),
              ),

              const Gap(50),

              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Stack untuk menumpuk Container lingkaran di depan TextField
                    Stack(
                      clipBehavior: Clip.none,  // Membuat agar lingkaran bisa melampaui batas Row
                      children: [
                        // Container untuk TextField
                        Container(
                          height: 42,
                          width: 300, // Menentukan lebar TextField
                          padding: const EdgeInsets.only(left: 70),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBFBFB),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xB1C5BAFF),
                                spreadRadius: 1,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: TextField(
                            style: GoogleFonts.plusJakartaSans(
                              color: Color(0xFF767676),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                color: Color(0xFF767676),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                            ),
                          ),
                        ),
                        // Container lingkaran yang ditumpuk di depan TextField
                        Positioned(
                          top: -4,   // Menempatkan lingkaran sedikit di atas
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFFBFBFB),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xB1C5BAFF),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/svgs/username.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(40),

              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Stack untuk menumpuk Container lingkaran di depan TextField
                    Stack(
                      clipBehavior: Clip.none,  // Membuat agar lingkaran bisa melampaui batas Row
                      children: [
                        // Container untuk TextField
                        Container(
                          height: 42,
                          width: 300, // Menentukan lebar TextField
                          padding: const EdgeInsets.only(left: 70),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBFBFB),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xB1C5BAFF),
                                spreadRadius: 1,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: TextField(
                            style: GoogleFonts.plusJakartaSans(
                              color: Color(0xFF767676),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                color: Color(0xFF767676),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 11.0),
                            ),
                          ),
                        ),
                        // Container lingkaran yang ditumpuk di depan TextField
                        Positioned(
                          top: -4,   // Menempatkan lingkaran sedikit di atas
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFFBFBFB),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xB1C5BAFF),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/svgs/password.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Gap(40),

              ButtonSignin(buttonText: 'Sign in'),

              const Gap(12),

              Text('Lupa password?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF767676)
                ),
              ),

              Spacer(),
              
              Column(
                children: [
                  SizedBox(
                    width: 340,
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: ColorConstant.abu,
                            thickness: 1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Atau sign in dengan',
                            style: GoogleFonts.plusJakartaSans(
                              color: ColorConstant.abu,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: ColorConstant.abu,
                            thickness: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google button
                      Container(
                        padding: EdgeInsets.all(12),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xB1C5BAFF),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/google.png', // Gantilah dengan path logo Google yang sudah bulat
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      // Facebook button
                      Container(
                        padding: EdgeInsets.all(12),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xB1C5BAFF),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/facebook.png', // Gantilah dengan path logo Facebook yang sudah bulat
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),

                  const Gap(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorConstant.abu,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Aksi ketika "Sign up" ditekan
                          // print("Sign up clicked");
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Sign up',
                            style: GoogleFonts.plusJakartaSans(
                              color: ColorConstant.birumuda,  // Warna biru untuk "Sign up"
                              fontWeight: FontWeight.bold,  // Membuat teks lebih tebal
                              fontSize: 16,  // Ukuran font yang sama dengan teks sebelumnya
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )

            ],
          )
        )
      ),
    );
  }
}