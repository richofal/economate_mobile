import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/pages/history_page.dart';
import 'package:economate_mobile/pages/home_page.dart';
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
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(top: 11, left: 11, right: 11, bottom: 32),
                width: double.infinity,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonInsertOption(isLabel: "Pemasukan"),
                        const Gap(8),
                        ButtonInsertOption(isLabel: "Pengeluaran")
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
                        ButtonSubmitOption(),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
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

  // Widget buildBottomNav() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.shifting,
  //     backgroundColor: ColorConstant.birumuda,
  //     selectedItemColor: ColorConstant.birumuda,
  //     currentIndex: selectedPage,
  //     items: [
  //       BottomNavigationBarItem(label: '',icon: SvgPicture.asset('asset/svgs/house.svg', colorFilter: ColorFilter.mode(ColorConstant.putih, BlendMode.srcIn)), backgroundColor: ColorConstant.putih),
  //       BottomNavigationBarItem(label: '',icon: SvgPicture.asset('asset/svgs/clock.svg', colorFilter: ColorFilter.mode(ColorConstant.putih, BlendMode.srcIn)), backgroundColor: ColorConstant.putih),
  //       BottomNavigationBarItem(label: '',icon: SvgPicture.asset('asset/svgs/wallet.svg', colorFilter: ColorFilter.mode(ColorConstant.putih, BlendMode.srcIn)), backgroundColor: ColorConstant.putih),
  //       BottomNavigationBarItem(label: '',icon: SvgPicture.asset('asset/svgs/profile.svg', colorFilter: ColorFilter.mode(ColorConstant.putih, BlendMode.srcIn)), backgroundColor: ColorConstant.putih)
  //     ],
  //     onTap: (int index) {
  //       _pageController.animateToPage(index, duration: Duration(microseconds: 300), curve: Curves.easeIn);
  //     },
  //   );
  // }

  onPageChange(int index) {
    setState(() {
      selectedPage = index;
    });
  }
}
