import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/listwallet.dart';
import 'package:economate_mobile/widgets/saldobesar_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/models/wallet_model.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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

      final response = await _supabase
          .from('wallets')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final wallets =
          (response as List).map((json) => Wallet.fromMap(json)).toList();

      setState(() {
        _wallets = wallets;
        _totalBalance = wallets.fold(
          0.0,
          (sum, wallet) => sum + wallet.balance,
        );
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Gagal memuat data';
        _isLoading = false;
      });
    }
  }

  void _setupRealtimeListener() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    _supabase
        .channel('wallet_changes_${userId.substring(0, 8)}')
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
            if (mounted) _loadWallets();
          },
        )
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.putihbiru,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Wallet',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.birumuda
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
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SaldobesarHome(
                          type: 'Saldo', 
                          nominal: _totalBalance.toStringAsFixed(0)
                        )
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
                      child: _wallets.isEmpty && !_isLoading
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