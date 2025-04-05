import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';

class BackgroundProfile extends StatelessWidget{
  final Widget child;

  const BackgroundProfile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -100,
            right: -100,
            top: -300,
            child: ClipOval(
              child: Container(
                height: 600,
                width: 1000,
                color: ColorConstant.birumuda,
              ),
            ),
          ),
          SafeArea(child: child)
        ],
      ),
    );
  }
}