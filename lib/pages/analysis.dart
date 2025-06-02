import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/models/transaction_model.dart';
import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:economate_mobile/widgets/list_bulan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    
    // Load data saat pertama kali dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TransactionProvider>(context, listen: false);
      provider.loadTransactions();
    });
  }

  Map<String, MonthlyData> _groupTransactionsByMonth(List<Transaction> transactions) {
    final Map<String, MonthlyData> monthlyData = {};

    for (var transaction in transactions) {
      final monthYear = DateFormat('MMMM yyyy').format(transaction.date);
      final month = DateFormat('MMMM').format(transaction.date);

      if (!monthlyData.containsKey(monthYear)) {
        monthlyData[monthYear] = MonthlyData(
          month: month,
          pemasukan: 0.0,
          pengeluaran: 0.0,
        );
      }

      if (transaction.isIncome) {
        monthlyData[monthYear]!.pemasukan += transaction.amount;
      } else {
        monthlyData[monthYear]!.pengeluaran += transaction.amount;
      }
    }

    return monthlyData;
  }

  List<ChartData> _prepareChartData(Map<String, MonthlyData> monthlyData) {
    return monthlyData.entries.map((entry) {
      return ChartData(
        entry.value.month,
        entry.value.pemasukan,
        entry.value.pengeluaran,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          final monthlyData = _groupTransactionsByMonth(provider.transactions);
          final chartData = _prepareChartData(monthlyData);
          final sortedMonths = monthlyData.entries.toList()
            ..sort((a, b) => DateFormat('MMMM yyyy')
                .parse(a.key)
                .compareTo(DateFormat('MMMM yyyy').parse(b.key)));

          return Container(
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
                              'Analysis',
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
                          height: 200,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorConstant.putih,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstant.hitamshadow,
                                spreadRadius: 1,
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: SfCartesianChart(
                            tooltipBehavior: _tooltipBehavior,
                            zoomPanBehavior: _zoomPanBehavior,
                            primaryXAxis: CategoryAxis(
                              labelRotation: -45,
                              labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              numberFormat: NumberFormat.compact(),
                              labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            series: <CartesianSeries>[
                              ColumnSeries<ChartData, String>(
                                name: 'Pemasukan',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.month,
                                yValueMapper: (ChartData data, _) => data.income,
                                color: ColorConstant.birumuda,
                              ),
                              ColumnSeries<ChartData, String>(
                                name: 'Pengeluaran',
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.month,
                                yValueMapper: (ChartData data, _) => data.expense,
                                color: Colors.red[200], // Ganti dengan warna yang sesuai
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorConstant.putih,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.hitamshadow,
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: provider.isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: ListView(
                                      children: [
                                        Column(
                                          children: sortedMonths.map((entry) {
                                            final data = entry.value;
                                            final total = data.pemasukan + data.pengeluaran;
                                            final incomePercent = total > 0
                                                ? ((data.pemasukan) / total * 100).round()
                                                : 0;
                                            final expensePercent = total > 0
                                                ? ((data.pengeluaran) / total * 100).round()
                                                : 0;

                                            return ListBulan(
                                              isMonth: data.month,
                                              isPemasukan: data.pemasukan,
                                              persenPemasukan: '$incomePercent%',
                                              isPengeluaran: data.pengeluaran,
                                              persenPengeluaran: '$expensePercent%',
                                            );
                                          }).toList(),
                                        ),
                                      ],
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
          );
        },
      ),
    );
  }
}

class ChartData {
  final String month;
  final double income;
  final double expense;

  ChartData(this.month, this.income, this.expense);
}

class MonthlyData {
  final String month;
  double pemasukan;
  double pengeluaran;

  MonthlyData({
    required this.month,
    required this.pemasukan,
    required this.pengeluaran,
  });
}