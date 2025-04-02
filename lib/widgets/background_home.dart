import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';

class BackgroundHome extends StatelessWidget{
  final Widget child;

  const BackgroundHome({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 270,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstant.birumuda,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14)
              )
            ),
          ),
          SafeArea(child: child)
        ],
      )
    );
  }
}