import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF089BFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ), // Jarak dari kanan kiri
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center secara vertikal
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center secara horizontal
            children: [
              // Bold "teman"
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans', // Custom font
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
    );
  }
}
