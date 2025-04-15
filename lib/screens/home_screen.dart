import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/pages/history_page.dart';
import 'package:economate_mobile/pages/home_page.dart';
import 'package:economate_mobile/pages/pemasukan.dart';
import 'package:economate_mobile/pages/pengeluaran.dart';
import 'package:economate_mobile/pages/profile_page.dart';
import 'package:economate_mobile/pages/wallet_page.dart';
import 'package:economate_mobile/widgets/button_insert_option.dart';
import 'package:economate_mobile/widgets/button_submit_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int selectedPage = 0;
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [buildPageView()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalInsert(context);
        },
        backgroundColor: ColorConstant.birumuda,
        elevation: 0,
        shape: CircleBorder(),
        child: SvgPicture.asset('assets/svgs/add.svg', width: 30),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        color: ColorConstant.birumuda,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              icon: SvgPicture.asset('assets/svgs/house.svg', height: 36),
              onPressed: () {
                _pageController.animateToPage(
                  0,
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/svgs/clock.svg', height: 36),
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            const Gap(32),
            IconButton(
              icon: SvgPicture.asset('assets/svgs/wallet.svg', height: 36),
              onPressed: () {
                _pageController.animateToPage(
                  2,
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/svgs/profile.svg', height: 36),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> modalInsert(BuildContext context) {
    bool isPemasukanSelected = false;
    bool isPengeluaranSelected = false;

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                top: 11,
                left: 11,
                right: 11,
                bottom: 32,
              ),
              width: double.infinity,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPemasukanSelected = true;
                                isPengeluaranSelected = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color:
                                    isPemasukanSelected
                                        ? ColorConstant.birumuda
                                        : ColorConstant.putih,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstant.birushadow,
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Pemasukan',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isPemasukanSelected
                                            ? ColorConstant.putih
                                            : ColorConstant.birumuda,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPemasukanSelected = false;
                                isPengeluaranSelected = true;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color:
                                    isPengeluaranSelected
                                        ? ColorConstant.birumuda
                                        : ColorConstant.putih,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstant.birushadow,
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Pengeluaran',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isPengeluaranSelected
                                            ? ColorConstant.putih
                                            : ColorConstant.birumuda,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            color: ColorConstant.putih,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstant.birushadow,
                                spreadRadius: 1,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Batal',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.hitam,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          if (isPemasukanSelected) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pemasukan(),
                              ),
                            );
                          }
                          if (isPengeluaranSelected) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pengeluaran(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 260,
                          padding: EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            color:
                                (isPemasukanSelected || isPengeluaranSelected)
                                    ? ColorConstant.birumuda
                                    : ColorConstant.putih,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstant.birushadow,
                                spreadRadius: 1,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Buat Transaksi',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color:
                                    (isPemasukanSelected ||
                                            isPengeluaranSelected)
                                        ? ColorConstant.putih
                                        : ColorConstant.birumuda,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildPageView() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        children: [HomePage(), HistoryPage(), WalletPage()],
        onPageChanged: (index) {
          onPageChange(index);
        },
      ),
    );
  }

  onPageChange(int index) {
    setState(() {
      selectedPage = index;
    });
  }
}
