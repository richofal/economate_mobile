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
          Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              color: ColorConstant.birumuda,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(300),
                bottomRight: Radius.circular(300)
              )
            ),
          ),
          SafeArea(child: child)
        ],
      ),
    );
  }
}