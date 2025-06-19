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

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final response = await supabase
          .from('profiles')
          .select('country, province, city, address')
          .eq('id', userId)
          .single();

      if (response != null) {
        setState(() {
          _country = response['country'] ?? 'Indonesia';
          _province = response['province'] ?? 'Jawa Timur';
          _city = response['city'] ?? 'Surabaya';
          _address = response['address'] ?? 'Jl. Rajawali Utara IV No.8';
        });
      }
    }
  }

  Future<void> _updateAddress(Map<String, dynamic> updates) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId != null) {
      final response = await supabase
          .from('profiles')
          .upsert({
            'id': userId,
            ...updates,
            'updated_at': DateTime.now().toIso8601String(),
          });

      if (response.error == null) {
        setState(() {
          if (updates.containsKey('country')) _country = updates['country'];
          if (updates.containsKey('province')) _province = updates['province'];
          if (updates.containsKey('city')) _city = updates['city'];
          if (updates.containsKey('address')) _address = updates['address'];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Alamat berhasil diperbarui')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui alamat: ${response.error?.message}')),
        );
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
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _updateAddress({field: controller.text});
              Navigator.pop(context);
            },
            child: Text('Simpan'),
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
        title: Text('Edit Alamat Lengkap'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'Negara'),
              ),
              const Gap(10),
              TextField(
                controller: provinceController,
                decoration: InputDecoration(labelText: 'Provinsi'),
              ),
              const Gap(10),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'Kota'),
              ),
              const Gap(10),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _updateAddress({
                'country': countryController.text,
                'province': provinceController.text,
                'city': cityController.text,
                'address': addressController.text,
              });
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Negara',
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
                      onTap: () => _showEditDialog('Negara', _country, 'country'),
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
                                _country,
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

                    const Gap(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Provinsi',
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
                      onTap: () => _showEditDialog('Provinsi', _province, 'province'),
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
                                _province,
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

                    const Gap(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Kota',
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
                      onTap: () => _showEditDialog('Kota', _city, 'city'),
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
                                _city,
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
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Alamat',
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
                      onTap: () => _showEditDialog('Alamat', _address, 'address'),
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
                                _address,
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
            ],
          ),
        ),
      ),
    );
  }
}