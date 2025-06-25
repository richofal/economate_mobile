import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/constants/transaction_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownCategory extends StatelessWidget {
  final String isHint;
  final bool isIncome;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? selectedValue;

  const DropdownCategory({
    super.key,
    required this.isHint,
    required this.isIncome,
    required this.items,
    required this.onChanged,
    this.validator,
    this.initialValue,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: isHint,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: ColorConstant.abu,
          ),
        ),
        value: selectedValue,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorConstant.hitam,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: ColorConstant.hitam,
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: ColorConstant.birumuda,
        ),
        isExpanded: true,
      ),
    );
  }
}