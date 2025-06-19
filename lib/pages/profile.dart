import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final supabase = Supabase.instance.client;
  String _fullName = 'Nama lengkap';
  String _displayName = 'Nama tampilan';
  String _birthDate = 'Tanggal lahir';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final response =
          await supabase.from('profiles').select().eq('id', userId).single();

      if (response != null) {
        setState(() {
          _fullName = response['full_name'] ?? 'Nama lengkap';
          _displayName = response['display_name'] ?? 'Nama tampilan';
          _birthDate = response['birth_date'] ?? 'Tanggal lahir';
        });
      }
    }
  }

  Future<void> _updateProfile(String field, String newValue) async {
    if (!mounted) return;

    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final response = await supabase.from('profiles').upsert({
        'id': userId,
        field: newValue,
        'updated_at': DateTime.now().toIso8601String(),
      });

      if (response.error == null && mounted) {
        setState(() {
          if (field == 'full_name') _fullName = newValue;
          if (field == 'display_name') _displayName = newValue;
          if (field == 'birth_date') _birthDate = newValue;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui')),
        );
      }
    }
  }

  void _showEditDialog(String title, String currentValue, String field) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit $title'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Masukkan $title baru'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  _updateProfile(field, controller.text);
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
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
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Profile',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Nama lengkap',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.abu,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap:
                          () => _showEditDialog(
                            'Nama lengkap',
                            _fullName,
                            'full_name',
                          ),
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
                          padding: const EdgeInsets.only(left: 12, right: 16),
                          child: Row(
                            children: [
                              const Gap(10),
                              Text(
                                _fullName,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.abu,
                                ),
                              ),
                              const Spacer(),
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
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Nama tampilan',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.abu,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap:
                          () => _showEditDialog(
                            'Nama tampilan',
                            _displayName,
                            'display_name',
                          ),
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
                          padding: const EdgeInsets.only(left: 12, right: 16),
                          child: Row(
                            children: [
                              const Gap(10),
                              Text(
                                _displayName,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.abu,
                                ),
                              ),
                              const Spacer(),
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
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal lahir',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.abu,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap:
                          () => _showEditDialog(
                            'Tanggal lahir',
                            _birthDate,
                            'birth_date',
                          ),
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
                          padding: const EdgeInsets.only(left: 12, right: 16),
                          child: Row(
                            children: [
                              const Gap(10),
                              Text(
                                _birthDate,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.abu,
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                'assets/svgs/pencil.svg',
                                height: 24,
                                width: 24,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  ColorConstant.birumuda,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
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
