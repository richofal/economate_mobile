import 'package:economate_mobile/pages/analysis.dart';
import 'package:economate_mobile/pages/shopping.dart';
import 'package:economate_mobile/pages/splitbill.dart';
import 'package:economate_mobile/widgets/background_home.dart';
import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/fitur_home.dart';
import 'package:economate_mobile/widgets/listhistory.dart';
import 'package:economate_mobile/widgets/saldobesar_home.dart';
import 'package:economate_mobile/widgets/saldokecil_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/models/wallet_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Wallet> _wallets = [];
  double _totalBalance = 0;
  double _totalIncome = 0; // You'll need to implement this based on your transactions
  double _totalExpense = 0; // You'll need to implement this based on your transactions
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWallets();
    _setupRealtimeListener();
    // You should also load transactions here to calculate income/expense
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
      body: BackgroundHome(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hi, Taraka',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.putih,
                    ),
                  ),
                  SvgPicture.asset('assets/svgs/pfp.svg',
                    height: 35,
                    width: 35,
                  )
                ],
              ),
              
              const Gap(20),

              // Display loading indicator while data is loading
              _isLoading 
                  ? CircularProgressIndicator(color: ColorConstant.putih)
                  : SaldobesarHome(type: "Saldo", nominal: _totalBalance.toStringAsFixed(0)),

              const Gap(20),

              Container(
                height: 64,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstant.birumuda,
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
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svgs/panahatas.svg',
                        height: 40,
                        width: 40,
                      ),
                          
                      SaldokecilHome(type: 'Pemasukan', nominal: _totalIncome.toStringAsFixed(0)),

                      Container(
                        height: 50,
                        width: 1.5,
                        decoration: BoxDecoration(
                          color: ColorConstant.putih
                        ),
                      ),

                      SaldokecilHome(type: 'Pengeluaran', nominal: _totalExpense.toStringAsFixed(0)),

                      SvgPicture.asset('assets/svgs/panahbawah.svg',
                        height: 40,
                        width: 40,
                      ),
                    ],
                  ),
                )
              ),

              const Gap(10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FiturHome(type: 'Analisa', fitur: Analysis(),),
                  FiturHome(type: 'Split Bill', fitur: Splitbill()),
                  FiturHome(type: 'Shopping', fitur: Shopping(),),
                ],
              ),

              const Gap(10),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.putih,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.hitamshadow,
                        spreadRadius: 1,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ListView(
                    padding: EdgeInsets.only(top: 6),
                    children: [
                      Listhistory(isIcon: 'makan', isTitle: 'Ramen', isDate: '11 Maret 2025', isNominal: -36000),
                      Listhistory(isIcon: 'ball', isTitle: 'Basket Angkatan', isDate: '11 Maret 2025', isNominal: -25000),
                      Listhistory(isIcon: 'paper', isTitle: 'Print laporan', isDate: '11 Maret 2025', isNominal: -6000),
                      Listhistory(isIcon: 'cash', isTitle: 'Saku bulanan', isDate: '11 Maret 2025', isNominal: 300000),
                      Listhistory(isIcon: 'makan', isTitle: 'Ciput', isDate: '11 Maret 2025', isNominal: -11000),
                      Listhistory(isIcon: 'paper', isTitle: 'Kertas folio', isDate: '11 Maret 2025', isNominal: -10000),
                      Listhistory(isIcon: 'makan', isTitle: 'Indomie', isDate: '11 Maret 2025', isNominal: -12000),
                      Listhistory(isIcon: 'makan', isTitle: 'Somay', isDate: '11 Maret 2025', isNominal: -16000),
                      Listhistory(isIcon: 'makan', isTitle: 'Chicken Katsu', isDate: '11 Maret 2025', isNominal: -13000),
                    ],
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}