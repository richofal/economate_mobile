import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/pages/history_page.dart';
import 'package:economate_mobile/pages/home_page.dart';
import 'package:economate_mobile/pages/profile_page.dart';
import 'package:economate_mobile/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildPageView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: ColorConstant.birumuda,
        elevation: 0,
        shape: CircleBorder(),
        child: SvgPicture.asset('assets/svgs/add.svg',
          width: 30,
        ),
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
              icon: SvgPicture.asset('assets/svgs/house.svg',
                height: 36,
              ),
              onPressed: () {
                _pageController.animateToPage(0, duration: Duration(microseconds: 300), curve: Curves.easeIn);
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/svgs/clock.svg',
                height: 36,
              ),
              onPressed: () {
                _pageController.animateToPage(1, duration: Duration(microseconds: 300), curve: Curves.easeIn);
              },
            ),
            const Gap(32),
            IconButton(
              icon: SvgPicture.asset('assets/svgs/wallet.svg',
                height: 36,
              ),
              onPressed: () {
                _pageController.animateToPage(2, duration: Duration(microseconds: 300), curve: Curves.easeIn);
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/svgs/profile.svg',
                height: 36,
              ),
              onPressed: () {
                _pageController.animateToPage(3, duration: Duration(microseconds: 300), curve: Curves.easeIn);
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget buildPageView() {
    return Expanded(
      // height: MediaQuery.of(context).size.height,
      // height: double.infinity,
      // width: MediaQuery.of(context).size.width,
      child: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          HistoryPage(),
          WalletPage(),
          ProfilePage()
        ],
        onPageChanged: (index) {
          onPageChange(index);
        }
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

