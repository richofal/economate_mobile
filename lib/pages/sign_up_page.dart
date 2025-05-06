import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/provider/authentication_provider.dart';
import 'package:economate_mobile/widgets/textfield_email.dart';
import 'package:economate_mobile/widgets/textfield_password.dart';
import 'package:economate_mobile/widgets/textfield_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F9FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'EconoMate',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF089BFF),
                  ),
                ),

                const Gap(10),

                Image.asset(
                  'assets/images/logobiru.png',
                  height: 90,
                  width: 90,
                ),

                const Gap(12),

                Text(
                  'Selamat datang!',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF767676),
                  ),
                ),

                const Gap(5),

                Text(
                  'Daftarkan akun mu disini',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF767676),
                  ),
                ),

                const Gap(26),

                Form(
                  key: loadAuth.signup,
                  child: Column(
                    children: [
                      TextfieldSignin(isLabel: 'Username', isObscure: false),

                      const Gap(40),

                      TextfieldEmail(controller: email),

                      const Gap(40),

                      TextfieldPassword(controller: password),

                      const Gap(40),

                      TextfieldSignin(
                        isLabel: 'Confirm Password',
                        isObscure: true,
                      ),

                      const Gap(30),

                      TextButton(
                        onPressed: () async {
                          await loadAuth.submit();
                          // await FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, '/home');
                          // setState(() {
                          //   loadAuth.isLogin = !loadAuth.isLogin;
                          // });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: ColorConstant.birumuda,
                          padding: EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 1,
                          ),
                          minimumSize: Size(170, 42),
                        ),
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xFFFBFBFB),
                          ),
                        ),
                      ),
                    ],
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
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
                          'Sudah punya akun? ',
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorConstant.abu,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              loadAuth.isLogin = !loadAuth.isLogin;
                            });
                            Navigator.pushNamed(context, '/signIn');
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Sign In',
                              style: GoogleFonts.plusJakartaSans(
                                color:
                                    ColorConstant
                                        .birumuda, // Warna biru untuk "Sign up"
                                fontWeight:
                                    FontWeight.bold, // Membuat teks lebih tebal
                                fontSize:
                                    16, // Ukuran font yang sama dengan teks sebelumnya
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
