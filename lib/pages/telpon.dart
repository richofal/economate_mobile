import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Telpon extends StatefulWidget {
  const Telpon({super.key});

  @override
  State<Telpon> createState() => _TelponState();
}

class _TelponState extends State<Telpon> {
  final supabase = Supabase.instance.client;
  String _phoneNumber = '+62 812 3456 7890';

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  Future<void> _loadPhoneNumber() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final response = await supabase
          .from('profiles')
          .select('phone')
          .eq('id', userId)
          .single();

      if (response != null) {
        setState(() {
          _phoneNumber = response['phone'] ?? '+62 812 3456 7890';
        });
      }
    }
  }

  Future<void> _updatePhoneNumber(String newPhone) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final response = await supabase
          .from('profiles')
          .upsert({
            'id': userId,
            'phone': newPhone,
            'updated_at': DateTime.now().toIso8601String(),
          });

      if (response.error == null) {
        setState(() {
          _phoneNumber = newPhone;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nomor telepon berhasil diperbarui')),
        );
      }
    }
  }

  void _showEditDialog() {
    final controller = TextEditingController(text: _phoneNumber);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Nomor Telepon'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Masukkan nomor telepon'),
          keyboardType: TextInputType.phone,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _updatePhoneNumber(controller.text);
              Navigator.pop(context);
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstant.putihbiru,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Telpon',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),

                    const Gap(10),

                    GestureDetector(
                      onTap: _showEditDialog,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.putih,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.birushadow,
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 12, right: 16),
                          child: Row(
                            children: [
                              const Gap(10),
                              Text(
                                _phoneNumber,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.abu,
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                'assets/svgs/pensil.svg',
                                height: 24,
                                width: 24,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const Gap(12),

                    GestureDetector(
                      onTap: _showEditDialog,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.birumuda,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.hitamshadow,
                              spreadRadius: 1,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Edit',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.putih,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/back.svg',
                    height: 30,
                    width: 30,
                    colorFilter: ColorFilter.mode(
                      ColorConstant.birumuda,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}