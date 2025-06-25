import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/models/wallet_model.dart';
import 'package:economate_mobile/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DropdownWallet extends StatelessWidget {
  final String isHint;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final List<String> items;
  final List<String> values;
  final String? initialValue;
  final String? selectedValue;

  const DropdownWallet({
    super.key,
    required this.isHint,
    required this.onChanged,
    this.validator,
    required this.items,
    required this.values,
    this.initialValue,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

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
      child: walletProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstant.birumuda,
              ),
            )
          : walletProvider.wallets.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada wallet',
                    style: GoogleFonts.plusJakartaSans(),
                  ),
                )
              : DropdownButtonFormField<String>(
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
                  items: List.generate(items.length, (index) {
                    return DropdownMenuItem<String>(
                      value: values[index],
                      child: Text(
                        items[index],
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: ColorConstant.hitam,
                        ),
                      ),
                    );
                  }),
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