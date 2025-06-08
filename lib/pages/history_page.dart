import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/models/transaction_model.dart';
import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:economate_mobile/widgets/listhistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _transactionType = 'Semua'; // 'Semua', 'Pengeluaran', 'Pemasukan'
  String _category = 'Semua';
  String _month = 'Semua';
  String _year = 'Semua';

  @override
  void initState() {
    super.initState();
    // Load transactions when the page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false).loadTransactions();
    });
  }

  List<Transaction> _filterTransactions(List<Transaction> transactions) {
    return transactions.where((transaction) {
      // Filter berdasarkan jenis transaksi
      if (_transactionType == 'Pengeluaran' && transaction.isIncome) {
        return false;
      }
      if (_transactionType == 'Pemasukan' && !transaction.isIncome) {
        return false;
      }

      // Filter berdasarkan kategori
      if (_category != 'Semua' && transaction.category != _category) {
        return false;
      }

      // Filter berdasarkan bulan
      if (_month != 'Semua') {
        final monthNames = [
          'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
          'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
        ];
        final monthIndex = monthNames.indexOf(_month);
        if (transaction.date.month != monthIndex + 1) {
          return false;
        }
      }

      // Filter berdasarkan tahun
      if (_year != 'Semua') {
        final selectedYear = int.tryParse(_year) ?? DateTime.now().year;
        if (transaction.date.year != selectedYear) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void _showCategoryFilter(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
    final categories = [
      'Semua',
      ...transactionProvider.transactions
          .map((t) => t.category)
          .toSet()
          .toList()
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pilih Kategori', style: GoogleFonts.plusJakartaSans()),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index], style: GoogleFonts.plusJakartaSans()),
                  onTap: () {
                    setState(() {
                      _category = categories[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showMonthFilter(BuildContext context) {
    final months = [
      'Semua',
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pilih Bulan', style: GoogleFonts.plusJakartaSans()),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: months.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(months[index], style: GoogleFonts.plusJakartaSans()),
                  onTap: () {
                    setState(() {
                      _month = months[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showYearFilter(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
    final years = [
      'Semua',
      ...transactionProvider.transactions
          .map((t) => t.date.year.toString())
          .toSet()
          .toList()
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pilih Tahun', style: GoogleFonts.plusJakartaSans()),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: years.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(years[index], style: GoogleFonts.plusJakartaSans()),
                  onTap: () {
                    setState(() {
                      _year = years[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final filteredTransactions = _filterTransactions(transactionProvider.transactions);

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('History',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.birumuda
                      ),
                    ),
                    if (_transactionType != 'Semua' || _category != 'Semua' || _month != 'Semua' || _year != 'Semua')
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _transactionType = 'Semua';
                            _category = 'Semua';
                            _month = 'Semua';
                            _year = 'Semua';
                          });
                        },
                        child: Text(
                          'Reset',
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorConstant.birumuda,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),

                const Gap(10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _FilterButton(
                      label: 'Pengeluaran',
                      width: 110,
                      isActive: _transactionType == 'Pengeluaran',
                      onTap: () {
                        setState(() {
                          _transactionType = _transactionType == 'Pengeluaran' 
                              ? 'Semua' 
                              : 'Pengeluaran';
                        });
                      },
                    ),
                    const Gap(6),
                    _FilterButton(
                      label: 'Pemasukan',
                      width: 110,
                      isActive: _transactionType == 'Pemasukan',
                      onTap: () {
                        setState(() {
                          _transactionType = _transactionType == 'Pemasukan' 
                              ? 'Semua' 
                              : 'Pemasukan';
                        });
                      },
                    ),
                  ],
                ),

                const Gap(6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Filter Kategori
                    _FilterButton(
                      label: _category,
                      width: 130,
                      isActive: _category != 'Semua',
                      onTap: () {
                        _showCategoryFilter(context);
                      },
                    ),
                    const Gap(6),
                    // Filter Bulan
                    _FilterButton(
                      label: _month,
                      width: 120,
                      isActive: _month != 'Semua',
                      onTap: () {
                        _showMonthFilter(context);
                      },
                    ),
                    const Gap(6),
                    // Filter Tahun
                    _FilterButton(
                      label: _year,
                      width: 90,
                      isActive: _year != 'Semua',
                      onTap: () {
                        _showYearFilter(context);
                      },
                    ),
                  ],
                ),

                const Gap(6),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.putih,
                      borderRadius: const BorderRadius.only(
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
                      : filteredTransactions.isEmpty
                          ? Center(
                              child: Text(
                                'Tidak ada transaksi yang sesuai',
                                style: GoogleFonts.plusJakartaSans(),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 6),
                              itemCount: filteredTransactions.length,
                              itemBuilder: (context, index) {
                                final transaction = filteredTransactions[index];
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

class _FilterButton extends StatelessWidget {
  final String label;
  final double width;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.width,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        width: width,
        decoration: BoxDecoration(
          color: isActive ? ColorConstant.birumuda : ColorConstant.putih,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.hitamshadow,
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color:
                      isActive ? ColorConstant.putih : ColorConstant.birumuda,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}