import 'dart:io';
import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/pages/alamat.dart';
import 'package:economate_mobile/pages/gender.dart';
import 'package:economate_mobile/pages/profile.dart';
import 'package:economate_mobile/pages/telpon.dart';
import 'package:economate_mobile/pages/tentang.dart';
import 'package:economate_mobile/pages/wallet_screen.dart';
import 'package:economate_mobile/widgets/background_profile.dart';
import 'package:economate_mobile/widgets/label_profile.dart';
import 'package:economate_mobile/widgets/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/pages/akun.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final supabase = Supabase.instance.client;
  String? _avatarUrl;
  String _displayName = 'Loading...'; // Ubah ini
  // Hapus _fullName karena kita akan menggunakan display_name
  String _gender = 'Laki-laki';
  String _location = 'Indonesia, Jawa timur';
  String _phoneNumber = '+62 812 3456 7890';

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
          _avatarUrl = response['avatar_url'];
          _displayName =
              response['display_name'] ?? 'User'; // Gunakan display_name
          _gender = response['gender'] ?? 'Gender';
          _phoneNumber = response['phone'] ?? 'Nomor Telpon';

          // Gabungkan data alamat
          final country = response['country'] ?? 'Negara';
          final province = response['province'] ?? 'Provinsi';
          _location = '$country, $province';
        });
      }
    }
  }

  Future<void> _uploadAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final fileExtension = pickedFile.path.split('.').last;
      final fileName = 'avatar_$userId.$fileExtension';
      final file = File(pickedFile.path);

      try {
        // Upload file to Supabase Storage
        await supabase.storage
            .from('avatars')
            .upload(
              fileName,
              file,
              fileOptions: FileOptions(
                contentType: 'image/$fileExtension',
                upsert: true,
              ),
            );

        // Get public URL
        final avatarUrl = supabase.storage
            .from('avatars')
            .getPublicUrl(fileName);

        // Update profile with new avatar URL
        final updateResponse = await supabase.from('profiles').upsert({
          'id': userId,
          'avatar_url': avatarUrl,
          'updated_at': DateTime.now().toIso8601String(),
        });

        if (updateResponse.error == null) {
          setState(() {
            _avatarUrl = avatarUrl;
          });
        }
      } catch (e) {
        // Handle upload error
        print('Error uploading avatar: $e');
        // You might want to show a snackbar or alert to the user here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundProfile(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Gap(70),
                    Text(
                      _displayName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.putih,
                      ),
                    ),
                    const Gap(12),

                    GestureDetector(
                      onTap: _uploadAvatar,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.birushadow,
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            height: 150,
                            width: 150,
                            color: ColorConstant.putih,
                            child:
                                _avatarUrl != null
                                    ? Image.network(
                                      _avatarUrl!,
                                      fit: BoxFit.cover,
                                    )
                                    : SvgPicture.asset(
                                      'assets/svgs/logo.svg',
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                        ColorConstant.birumuda,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),

                    LabelProfile(isLabel: 'Profil ku'),

                    ProfileList(
                      isIcon: 'nama',
                      isText: 'Profil',
                      isPage: Profile(),
                    ),
                    ProfileList(
                      isIcon: 'gender',
                      isText: 'Gender',
                      isPage: Gender(),
                    ),
                    ProfileList(
                      isIcon: 'location',
                      isText: 'Alamat',
                      isPage: Alamat(),
                    ),

                    const Gap(2),

                    LabelProfile(isLabel: 'Pengaturan Akun'),

                    ProfileList(
                      isIcon: 'akun',
                      isText: 'Akun ku',
                      isPage: Akun(),
                    ),
                    ProfileList(
                      isIcon: 'dompet',
                      isText: 'Dompet ku',
                      isPage: WalletScreen(),
                    ),
                    ProfileList(
                      isIcon: 'telp',
                      isText: 'Nomor Telpon',
                      isPage: Telpon(),
                    ),

                    const Gap(2),

                    LabelProfile(isLabel: 'Bantuan'),
                    ProfileList(
                      isIcon: 'tentang',
                      isText: 'Tentang kami',
                      isPage: Tentang(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/back.svg',
                  height: 30,
                  width: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
