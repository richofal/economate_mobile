import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  final supabase = Supabase.instance.client;
  String _gender = 'Laki-laki';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadGender();
  }

  Future<void> _loadGender() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        final response = await supabase
            .from('profiles')
            .select('gender')
            .eq('id', userId)
            .single()
            .timeout(const Duration(seconds: 5));

        if (response != null && mounted) {
          setState(() {
            _gender = response['gender'] ?? 'Laki-laki';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat gender: ${e.toString()}')),
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

  Future<void> _updateGender(String newGender) async {
    if (!mounted || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        final response = await supabase
            .from('profiles')
            .update({
              'gender': newGender,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId)
            .select()
            .single()
            .timeout(const Duration(seconds: 5));

        if (mounted) {
          setState(() {
            _gender = response['gender'] ?? newGender;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gender berhasil diperbarui')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui gender: ${e.toString()}')),
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

  void _showGenderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Gender'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Laki-laki'),
              onTap: () async {
                Navigator.pop(context);
                await _updateGender('Laki-laki');
              },
            ),
            ListTile(
              title: Text('Perempuan'),
              onTap: () async {
                Navigator.pop(context);
                await _updateGender('Perempuan');
              },
            ),
          ],
        ),
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
                          'Gender',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Container(
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
                              _gender,
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
                    const Gap(12),
                    GestureDetector(
                      onTap: _showGenderDialog,
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
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}