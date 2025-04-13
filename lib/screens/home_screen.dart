import 'package:economate_mobile/pages/history_page.dart';
import 'package:economate_mobile/pages/home_page.dart';
import 'package:economate_mobile/pages/profile.dart';
import 'package:economate_mobile/pages/wallet_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildPageView(),
          // buildBottomNav();
        ],
      ),
    );
  }
}

Widget buildPageView() {
  return PageView(
    children: [
      HomePage(),
      HistoryPage(),
      WalletPage(),
      Profile()
    ],
  );
}