import 'package:economate_mobile/widgets/button_signin.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('EconoMate', 
              style: GoogleFonts.plusJakartaSans(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: Color(0xFF089BFF)
              ),),
              const Gap(10),
              Image.asset(
                'assets/images/logobiru.png',
                height: 80,
                width: 80,
              ),
              const Gap(10),
              Text('Selamat datang kembali!',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFF767676)
              ),),
              const Gap(5),
              Text('Masukkan akun mu disini',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF767676)
              ),),
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
                          height: 40,
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
                            style: TextStyle(
                              color: Color(0xFF767676),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                color: Color(0xFF767676),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 17.0),
                            ),
                          ),
                        ),
                        // Container lingkaran yang ditumpuk di depan TextField
                        Positioned(
                          top: -4,   // Menempatkan lingkaran sedikit di atas
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(14),
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
                            child: Image.asset(
                              'assets/images/username.png',
                              fit: BoxFit.cover,
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
                          height: 40,
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
                            style: TextStyle(
                              color: Color(0xFF767676),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                color: Color(0xFF767676),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 17.0),
                            ),
                          ),
                        ),
                        // Container lingkaran yang ditumpuk di depan TextField
                        Positioned(
                          top: -4,   // Menempatkan lingkaran sedikit di atas
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(14),
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
                            child: Image.asset(
                              'assets/images/password.png',
                              // height: 20,
                              // width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Gap(40),

              ButtonSignin()


              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       height: 50,
              //       width: 50,
              //       decoration: BoxDecoration(
              //         color: Color(0xFFFBFBFB),
              //         borderRadius: BorderRadius.circular(30.0),                      
              //         boxShadow: [
              //           BoxShadow(
              //             color: Color(0xB1C5BAFF),
              //             spreadRadius: 1,
              //             blurRadius: 8,
              //           )                        
              //         ]
              //       ),
              //     ),

              //     Expanded(
              //       child: Container(
              //         height: 42,
              //         padding: const EdgeInsets.only(left: 60),
                      
              //         decoration: BoxDecoration(
              //           color: Color(0xFFFBFBFB),
              //           borderRadius: BorderRadius.circular(30.0),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Color(0xB1C5BAFF),
              //               spreadRadius: 1,
              //               blurRadius: 8,
              //             )
              //           ]
              //         ),
              //         child: TextField(
              //           style: TextStyle(
              //             color: Color(0xFF767676),
              //             fontSize: 12,
              //             fontWeight: FontWeight.w500
              //           ),
              //           decoration: InputDecoration(
              //             hintText: 'Username',
              //             hintStyle: TextStyle(
              //               color: Color(0xFF767676),
              //               fontSize: 12,
              //               fontWeight: FontWeight.w500
              //             ),
              //             border: InputBorder.none,
              //             contentPadding: EdgeInsets.symmetric(vertical: 17.0),
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // )


              // Container(
              //   height: 50,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFBFBFB),
              //     borderRadius: BorderRadius.circular(30.0),                      
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color(0xB1C5BAFF),
              //         spreadRadius: 1,
              //         blurRadius: 8,
              //       )                        
              //     ]
              //   ),
              // ),

              // Container(
              //   height: 42,
              //   padding: const EdgeInsets.only(left: 60),
                
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFBFBFB),
              //     borderRadius: BorderRadius.circular(30.0),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color(0xB1C5BAFF),
              //         spreadRadius: 1,
              //         blurRadius: 8,
              //       )
              //     ]
              //   ),
              //   child: TextField(
              //     style: TextStyle(
              //       color: Color(0xFF767676),
              //       fontSize: 12,
              //       fontWeight: FontWeight.w500
              //     ),
              //     decoration: InputDecoration(
              //       hintText: 'Username',
              //       hintStyle: TextStyle(
              //         color: Color(0xFF767676),
              //         fontSize: 12,
              //         fontWeight: FontWeight.w500
              //       ),
              //       border: InputBorder.none,
              //       contentPadding: EdgeInsets.symmetric(vertical: 17.0),
              //     ),
              //   ),
              // ),
              
            ],
          )
        )
      ),
    );
  }
}