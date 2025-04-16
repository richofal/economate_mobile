import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/signIn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.birumuda,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center secara vertikal
              crossAxisAlignment: CrossAxisAlignment.center, // Center secara horizontal
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans( // Custom font
                      fontSize: 18,
                      color: Colors.white, // Warna font putih
                    ),
                    children: [
                      TextSpan(text: 'Aplikasi yang siap jadi '), // Normal
                      TextSpan(
                        text: 'teman', // Bold
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' dalam mengelola keuangan pribadi'),
                    ],
                  ),
                ),
                SizedBox(height: 50), // Jarak antara teks dan logo
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
