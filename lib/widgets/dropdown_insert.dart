// dropdown_insert.dart
import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownInsert extends StatefulWidget {
  final String isHint;
  final bool isCategory;
  final List<String>? customItems;

  const DropdownInsert({
    super.key,
    required this.isHint,
    this.isCategory = true,
    this.customItems,
  });

  @override
  State<DropdownInsert> createState() => _DropdownInsertState();
}

class _DropdownInsertState extends State<DropdownInsert> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    List<String> items = widget.customItems ?? [
      if (widget.isCategory)
        ...(widget.isHint == 'Kategori' 
          ? ['Makanan', 'Alat Tulis Kantor', 'Olahraga', 'Lainnya']
          : ['Sangu', 'Gaji', 'Lainnya']),
      if (!widget.isCategory)
        ...['Wallet 1', 'Wallet 2', 'Wallet 3'], // Replace with actual wallet data
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: ColorConstant.putih,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.birushadow,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: DropdownButton<String>(
        hint: Text(
          widget.isHint,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: ColorConstant.abu,
          ),
        ),
        value: selectedValue,
        isExpanded: true,
        icon: SvgPicture.asset('assets/svgs/arrowsolid.svg'),
        iconSize: 30,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: ColorConstant.hitam,
        ),
        underline: SizedBox(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        dropdownColor: ColorConstant.putih,
      ),
    );
  }
}