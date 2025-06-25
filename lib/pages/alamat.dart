import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Alamat extends StatefulWidget {
  const Alamat({super.key});

  @override
  State<Alamat> createState() => _AlamatState();
}

class _AlamatState extends State<Alamat> {
  final supabase = Supabase.instance.client;
  String _country = 'Negara';
  String _province = 'Provinsi';
  String _city = 'Kota';
  String _address = 'Alamat';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        final response = await supabase
            .from('profiles')
            .select('country, province, city, address')
            .eq('id', userId)
            .single()
            .timeout(const Duration(seconds: 5));

        if (response != null && mounted) {
          setState(() {
            _country = response['country'] ?? 'Indonesia';
            _province = response['province'] ?? 'Jawa Timur';
            _city = response['city'] ?? 'Surabaya';
            _address = response['address'] ?? 'Jl. Rajawali Utara IV No.8';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat alamat: ${e.toString()}')),
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

  Future<void> _updateAddress(Map<String, dynamic> updates) async {
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
              ...updates,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId)
            .select()
            .single()
            .timeout(const Duration(seconds: 5));

        if (mounted) {
          setState(() {
            if (updates.containsKey('country')) _country = response['country'] ?? updates['country'];
            if (updates.containsKey('province')) _province = response['province'] ?? updates['province'];
            if (updates.containsKey('city')) _city = response['city'] ?? updates['city'];
            if (updates.containsKey('address')) _address = response['address'] ?? updates['address'];
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Alamat berhasil diperbarui')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui alamat: ${e.toString()}')),
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
      builder: (context) => AlertDialog(
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
              await _updateAddress({field: controller.text});
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showFullAddressEditDialog() {
    final countryController = TextEditingController(text: _country);
    final provinceController = TextEditingController(text: _province);
    final cityController = TextEditingController(text: _city);
    final addressController = TextEditingController(text: _address);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Alamat Lengkap'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: countryController,
                decoration: const InputDecoration(labelText: 'Negara'),
              ),
              const Gap(10),
              TextField(
                controller: provinceController,
                decoration: const InputDecoration(labelText: 'Provinsi'),
              ),
              const Gap(10),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'Kota'),
              ),
              const Gap(10),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _updateAddress({
                'country': countryController.text,
                'province': provinceController.text,
                'city': cityController.text,
                'address': addressController.text,
              });
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressField(String label, String value, VoidCallback onTap) {
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
                          'Alamat',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    _buildAddressField(
                      'Negara', 
                      _country, 
                      () => _showEditDialog('Negara', _country, 'country'),
                    ),
                    const Gap(10),
                    _buildAddressField(
                      'Provinsi', 
                      _province, 
                      () => _showEditDialog('Provinsi', _province, 'province'),
                    ),
                    const Gap(10),
                    _buildAddressField(
                      'Kota', 
                      _city, 
                      () => _showEditDialog('Kota', _city, 'city'),
                    ),
                    const Gap(10),
                    _buildAddressField(
                      'Alamat', 
                      _address, 
                      () => _showEditDialog('Alamat', _address, 'address'),
                    ),
                    const Gap(12),
                    GestureDetector(
                      onTap: _showFullAddressEditDialog,
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
                            'Edit Semua',
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