import 'package:economate_mobile/pages/analysis.dart';
import 'package:economate_mobile/pages/piechart.dart';
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
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/models/wallet_model.dart';
import 'package:economate_mobile/models/transaction_model.dart'; // Added import
import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:provider/provider.dart'; // Added import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Wallet> _wallets = [];
  List<Transaction> _recentTransactions = []; // Added transactions list
  double _totalBalance = 0;
  double _totalIncome = 0;
  double _totalExpense = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWallets();
      _loadRecentTransactions();
    });
    _setupRealtimeListener();
    _setupTransactionListener();
  }

  // Tambahkan method baru untuk listener transaksi
  void _setupTransactionListener() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    _supabase
        .channel('transaction_changes_${userId.substring(0, 8)}')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'transactions', // Ganti dengan nama tabel transaksi Anda
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            if (mounted)
              _loadRecentTransactions(); // Refresh saat ada perubahan
          },
        )
        .subscribe();
  }

  Future<void> _loadRecentTransactions() async {
    final transactionProvider = Provider.of<TransactionProvider>(
      context,
      listen: false,
    );

    try {
      await transactionProvider.loadTransactions();

      if (mounted) {
        setState(() {
          _recentTransactions =
              (transactionProvider.transactions
                      .where((t) => t.date != null)
                      .toList()
                    ..sort((a, b) => b.date!.compareTo(a.date!)))
                  .take(7)
                  .toList();

          _calculateTotals(transactionProvider.transactions);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load transactions: $e')),
        );
      }
    }
  }

  void _calculateTotals(List<Transaction> transactions) {
    _totalIncome = transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);

    _totalExpense = transactions
        .where((t) => !t.isIncome)
        .fold(0.0, (sum, t) => sum + t.amount);
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
                  Text(
                    'Hi, Taraka',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.putih,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svgs/pfp.svg',
                    height: 35,
                    width: 35,
                  ),
                ],
              ),

              const Gap(20),

              // Display loading indicator while data is loading
              _isLoading
                  ? CircularProgressIndicator(color: ColorConstant.putih)
                  : SaldobesarHome(
                    type: "Saldo",
                    nominal: _totalBalance.toStringAsFixed(0),
                  ),

              const Gap(20),

              // Ganti bagian yang menggunakan SaldokecilHome dengan ini:
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
                      SvgPicture.asset(
                        'assets/svgs/panahatas.svg',
                        height: 40,
                        width: 40,
                      ),

                      SaldokecilHome(
                        type: 'Pemasukan',
                        nominal: _totalIncome.toStringAsFixed(0),
                        isIncome: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => Piechart(isIncomePiechart: true),
                            ),
                          );
                        },
                      ),

                      Container(
                        height: 50,
                        width: 1.5,
                        decoration: BoxDecoration(color: ColorConstant.putih),
                      ),

                      SaldokecilHome(
                        type: 'Pengeluaran',
                        nominal: _totalExpense.toStringAsFixed(0),
                        isIncome: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Piechart(isIncomePiechart: false),
                            ),
                          );
                        },
                      ),

                      SvgPicture.asset(
                        'assets/svgs/panahbawah.svg',
                        height: 40,
                        width: 40,
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FiturHome(type: 'Analisa', fitur: Analysis()),
                  FiturHome(type: 'Split Bill', fitur: Splitbill()),
                  FiturHome(type: 'Shopping', fitur: Shopping()),
                ],
              ),

              const Gap(10),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.putih,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.hitamshadow,
                        spreadRadius: 1,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child:
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            padding: EdgeInsets.only(top: 6),
                            itemCount: _recentTransactions.length,
                            itemBuilder: (context, index) {
                              final transaction = _recentTransactions[index];
                              return Dismissible(
                                key: Key(transaction.id),
                                child: ListHistory(
                                  category: transaction.category,
                                  title: transaction.title,
                                  date:
                                      transaction
                                          .date, // Pass the DateTime directly
                                  amount: transaction.amount,
                                  isIncome: transaction.isIncome,
                                ),
                              );
                            },
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
