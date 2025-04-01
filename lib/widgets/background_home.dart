import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';

class BackgroundHome extends StatelessWidget{
  const BackgroundHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.birumuda,
          ),
        ),
      ),
    );
  }
}