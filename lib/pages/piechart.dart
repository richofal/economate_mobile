import 'package:economate_mobile/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Piechart extends StatelessWidget {
  final bool isIncomePiechart;

  const Piechart({super.key, this.isIncomePiechart = false});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions
        .where((t) => t.isIncome == isIncomePiechart)
        .toList();

    // Calculate total amount
    final totalAmount = transactions.fold<double>(
        0, (sum, transaction) => sum + transaction.amount);

    // Group by category and calculate percentages
    final categoryMap = <String, double>{};
    for (var transaction in transactions) {
      categoryMap.update(
        transaction.category,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    // Convert to list of PieData
    final pieData = categoryMap.entries
        .map((e) => PieData(
              e.key,
              e.value,
              (e.value / totalAmount * 100).round(),
            ))
        .toList();

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
                    const Gap(56),
                    
                    Container(
                      height: 90,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isIncomePiechart ? 'Pemasukan' : 'Pengeluaran',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.putih,
                              ),
                            ),
                            SizedBox(
                              width: 320,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rp',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.putih,
                                    ),
                                  ),
                                  const Gap(2),
                                  Text(
                                    NumberFormat('#,###').format(totalAmount),
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      color: ColorConstant.putih,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Gap(10),

                    // Pie Chart
                    Container(
                      height: 360,
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          PieSeries<PieData, String>(
                            dataSource: pieData,
                            xValueMapper: (PieData data, _) => data.category,
                            yValueMapper: (PieData data, _) => data.amount,
                            dataLabelMapper: (PieData data, _) =>
                                '${data.percentage}%',
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside,
                              textStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.hitam,
                              ),
                            ),
                            pointColorMapper: (PieData data, _) =>
                                _getCategoryColor(data.category),
                          ),
                        ],
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                          overflowMode: LegendItemOverflowMode.wrap,
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const Gap(10),

                    Expanded(
                      child: Container(
                        height: double.infinity,
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
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: ListView.builder(
                            itemCount: pieData.length,
                            itemBuilder: (context, index) {
                              final data = pieData[index];
                              return CategoryListItem(
                                category: data.category,
                                percentage: data.percentage,
                                amount: data.amount,
                                isIncome: isIncomePiechart,
                              );
                            },
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

  Color _getCategoryColor(String category) {
    final colors = [
      ColorConstant.birumuda,
      ColorConstant.merah,
      ColorConstant.hijau,
      ColorConstant.kuning,
      ColorConstant.ungu,
      ColorConstant.orange,
    ];
    return colors[category.hashCode % colors.length];
  }
}

class PieData {
  final String category;
  final double amount;
  final int percentage;

  PieData(this.category, this.amount, this.percentage);
}

class CategoryListItem extends StatelessWidget {
  final String category;
  final int percentage;
  final double amount;
  final bool isIncome;

  const CategoryListItem({
    super.key,
    required this.category,
    required this.percentage,
    required this.amount,
    this.isIncome = false,
  });

  String _getIconPath(String category) {
    final categoryKey = category.toLowerCase().trim();
    final iconMap = {
      'makanan': 'makanan',
      'transportasi': 'transportasi',
      'hiburan': 'hiburan',
      'belanjaan': 'belanjaan',
      'pekerjaan': 'pekerjaan',
      'olahraga': 'olahraga',
      'saku': 'saku',
      'gaji': 'gaji',
      'investasi': 'investasi',
      'hadiah': 'hadiah',
      'lainnya': 'lainnya',
    };
    final iconName = iconMap[categoryKey] ?? 'lainnya';
    return "assets/svgs/$iconName.svg";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: ColorConstant.putihbiru.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                _getIconPath(category),
                height: 32,
                width: 32,
                colorFilter: ColorFilter.mode(
                  ColorConstant.birumuda,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Category name and percentage
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorConstant.hitam,
                  ),
                ),
                const Gap(8),
                Text(
                  '$percentage%',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.abu,
                  ),
                ),
              ],
            ),
          ),
          
          // Amount
          Text(
            'Rp${NumberFormat('#,###').format(amount)}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ColorConstant.birumuda,
            ),
          ),
        ],
      ),
    );
  }
}