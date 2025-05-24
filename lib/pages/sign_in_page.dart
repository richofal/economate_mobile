import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/provider/authentication_provider.dart';
import 'package:economate_mobile/widgets/textfield_email.dart';
import 'package:economate_mobile/widgets/textfield_password.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF2F9FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'EconoMate',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: ColorConstant.birumuda,
                ),
              ),

              const Gap(10),

              Image.asset('assets/images/logobiru.png', height: 90, width: 90),

              const Gap(12),

              Text(
                'Selamat datang kembali!',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.abu,
                ),
              ),

              const Gap(5),

              Text(
                'Masukkan akun mu disini',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.abu,
                ),
              ),

              const Gap(50),

              if (authProvider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    authProvider.errorMessage!,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),

              Form(
                key: authProvider.signInFormKey,
                child: Column(
                  children: [
                    TextfieldEmail(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),

                    const Gap(40),

                    TextfieldPassword(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 8) {
                          return 'Password minimal 8 karakter';
                        }
                        return null;
                      },
                    ),

                    const Gap(40),

                    authProvider.isLoading
                        ? const CircularProgressIndicator()
                        : TextButton(
                          onPressed: () async {
                            if (authProvider.signInFormKey.currentState!
                                .validate()) {
                              try {
                                await authProvider.signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );

                                if (authProvider.isLoggedIn) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                }
                              } catch (e) {
                                // Error sudah ditangani di provider
                              }
                            }
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
                            'Sign in',
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

              const Gap(12),

              Text(
                'Lupa password?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.abu,
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
                          color: ColorConstant.putih,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.birushadow,
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/google.png',
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
                          color: ColorConstant.putih,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.birushadow,
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/facebook.png',
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Sign up',
                            style: GoogleFonts.plusJakartaSans(
                              color: ColorConstant.birumuda,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
    );
  }
}
