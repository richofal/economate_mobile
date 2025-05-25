import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:economate_mobile/widgets/filter_history.dart';
import 'package:economate_mobile/widgets/listhistory.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    // Load transactions when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false).loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

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
                    Text('History',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.birumuda
                      ),
                    ),
                  ],
                ),

                const Gap(10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FilterHistory(isLabel: 'Pengeluaran', isWidth: 130),
                  ],
                ),

                const Gap(6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FilterHistory(isLabel: 'Semua', isWidth: 150),
                    const Gap(6),
                    FilterHistory(isLabel: 'September', isWidth: 128),
                    const Gap(6),
                    FilterHistory(isLabel: '2025', isWidth: 80)
                  ],
                ),

                const Gap(6),

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
                    child: transactionProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : transactionProvider.transactions.isEmpty
                          ? Center(
                              child: Text(
                                'Belum ada transaksi',
                                style: GoogleFonts.plusJakartaSans(),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 6),
                              itemCount: transactionProvider.transactions.length,
                              itemBuilder: (context, index) {
                                final transaction = transactionProvider.transactions[index];
                                return ListHistory(
                                  category: transaction.category,
                                  title: transaction.title,
                                  date: transaction.date,
                                  amount: transaction.amount,
                                  isIncome: transaction.isIncome,
                                );
                              },
                            ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}