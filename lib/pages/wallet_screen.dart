import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/listwallet.dart';
import 'package:economate_mobile/widgets/saldobesar_home.dart';
import 'package:economate_mobile/models/wallet_model.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Wallet> _wallets = [];
  double _totalBalance = 0;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _setupRealtimeListener();
    _loadWallets();
  }

  Future<void> _loadWallets() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      debugPrint('Memuat data wallet...'); // Log debugging

      final response = await _supabase
          .from('wallets')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final wallets =
          (response as List).map((json) => Wallet.fromMap(json)).toList();

      debugPrint('Ditemukan ${wallets.length} wallet'); // Log debugging

      setState(() {
        _wallets = wallets;
        _totalBalance = wallets.fold(
          0.0,
          (sum, wallet) => sum + wallet.balance,
        );
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error: $e'); // Log error
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Gagal memuat data';
        _isLoading = false;
      });
    }
  }

  Future<double> _calculateTotalBalance(List<Wallet> wallets) async {
    return wallets.fold<double>(0.0, (sum, wallet) => sum + wallet.balance);
  }

  void _setupRealtimeListener() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    _supabase
        .channel(
          'wallet_changes_${userId.substring(0, 8)}',
        ) // Nama channel unik
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'wallets',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            debugPrint('Realtime update: ${payload.eventType}');
            if (mounted) _loadWallets();
          },
        )
        .subscribe();
  }

  void _showAddWalletDialog() {
    final nameController = TextEditingController();
    final balanceController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Tambah Dompet Baru',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                color: ColorConstant.birumuda,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Dompet',
                    labelStyle: GoogleFonts.plusJakartaSans(),
                  ),
                ),
                const Gap(10),
                TextField(
                  controller: balanceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Saldo Awal',
                    labelStyle: GoogleFonts.plusJakartaSans(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: GoogleFonts.plusJakartaSans(color: ColorConstant.abu),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final balance = double.tryParse(balanceController.text) ?? 0;

                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nama dompet tidak boleh kosong'),
                      ),
                    );
                    return;
                  }

                  try {
                    await _supabase.from('wallets').insert({
                      'user_id': _supabase.auth.currentUser?.id,
                      'name': name,
                      'balance': balance,
                    });
                    if (!mounted) return;
                    Navigator.pop(context);
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menambah dompet: $e')),
                    );
                  }
                },
                child: Text(
                  'Simpan',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorConstant.birumuda,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: ColorConstant.putihbiru),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: Row(
                    children: [
                      IconButton(
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
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Wallet',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.birumuda,
                      ),
                    ),
                  ],
                ),
                const Gap(10),

                // Error Message
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: GoogleFonts.plusJakartaSans(color: Colors.red),
                  ),

                // Loading Indicator
                if (_isLoading) const CircularProgressIndicator(),

                // Total Balance Card
                if (!_isLoading)
                  Container(
                    height: 108,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstant.birumuda,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SaldobesarHome(
                          type: 'Saldo',
                          nominal: _totalBalance.toStringAsFixed(0),
                        ),
                      ],
                    ),
                  ),

                const Gap(10),

                // Wallet List
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorConstant.putih,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x2B000000),
                          spreadRadius: 1,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
                      child: Column(
                        children: [
                          Expanded(
                            child:
                                _wallets.isEmpty && !_isLoading
                                    ? Center(
                                      child: Text(
                                        'Belum ada dompet',
                                        style: GoogleFonts.plusJakartaSans(),
                                      ),
                                    )
                                    : ListView.builder(
                                      itemCount: _wallets.length,
                                      itemBuilder: (context, index) {
                                        final wallet = _wallets[index];
                                        return Listwallet(
                                          isLabel: wallet.name,
                                          isNominal: wallet.balance,
                                        );
                                      },
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Tombol Tambah Dompet baru di luar container list wallet
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: GestureDetector(
                    onTap: _showAddWalletDialog,
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
                          )
                        ]
                      ),
                      child: Center(
                        child: Text('Tambahkan Dompet',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.putih
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}