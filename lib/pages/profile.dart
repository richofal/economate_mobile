import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          onTap: _showDatePicker,
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
                    _birthDate != 'Tanggal lahir'
                        ? DateFormat(
                          'dd MMMM yyyy',
                        ).format(DateTime.parse(_birthDate))
                        : 'Tanggal lahir',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.abu,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/svgs/calendar.svg', // Ganti dengan icon kalender jika ada
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
    );
  }

  Future<void> _loadProfile() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        final response = await supabase
            .from('profiles')
            .select()
            .eq('id', userId)
            .single()
            .timeout(const Duration(seconds: 5));

        if (response != null && mounted) {
          setState(() {
            _fullName = response['full_name'] ?? 'Nama lengkap';
            _displayName = response['display_name'] ?? 'Nama tampilan';
            _birthDate = response['birth_date'] ?? 'Tanggal lahir';
          });
        }
      }
    } catch (e) {
      // Handle error parsing tanggal
      if (e is FormatException && e.message.contains('Invalid date format')) {
        setState(() {
          _birthDate = 'Tanggal lahir';
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat profil: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateProfile(String field, String newValue) async {
    if (!mounted || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        // Gunakan update() bukan upsert() jika Anda hanya ingin mengupdate
        final response = await supabase
            .from('profiles')
            .update({
              field: newValue,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId)
            .select()
            .single()
            .timeout(const Duration(seconds: 5));

        if (mounted) {
          setState(() {
            if (field == 'full_name')
              _fullName = response['full_name'] ?? newValue;
            if (field == 'display_name')
              _displayName = response['display_name'] ?? newValue;
            if (field == 'birth_date')
              _birthDate = response['birth_date'] ?? newValue;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil berhasil diperbarui')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui profil: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
                onPressed: () async {
                  Navigator.pop(context);
                  await _updateProfile(field, controller.text);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _birthDate != 'Tanggal lahir'
              ? DateTime.parse(_birthDate)
              : DateTime.now().subtract(
                const Duration(days: 365 * 20),
              ), // Default 20 tahun lalu
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorConstant.birumuda, // Warna utama
              onPrimary: Colors.white, // Warna teks pada primary
              onSurface: ColorConstant.abu, // Warna teks biasa
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorConstant.birumuda, // Warna text button
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      await _updateProfile('birth_date', picked.toIso8601String());
    }
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
                    _buildProfileField(
                      label: 'Nama lengkap',
                      value: _fullName,
                      onTap:
                          () => _showEditDialog(
                            'Nama lengkap',
                            _fullName,
                            'full_name',
                          ),
                    ),
                    const Gap(10),
                    _buildProfileField(
                      label: 'Nama tampilan',
                      value: _displayName,
                      onTap:
                          () => _showEditDialog(
                            'Nama tampilan',
                            _displayName,
                            'display_name',
                          ),
                    ),
                    const Gap(10),
                    _buildDateField(),
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
              if (_isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
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
          onTap: onTap,
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
                    value,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.abu,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/svgs/pencil.svg',
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
