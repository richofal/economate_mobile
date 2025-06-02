import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/list_splitbill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class Splitbill extends StatefulWidget {
  const Splitbill({super.key});

  @override
  State<Splitbill> createState() => _SplitbillState();
}

class _SplitbillState extends State<Splitbill> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _bills = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadBills();
    _setupRealtimeListener();
  }

  Future<void> _loadBills() async {
    if (!mounted) return;

    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response = await _supabase
          .from('split_bills')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      if (mounted) {
        setState(() {
          _bills = List<Map<String, dynamic>>.from(response);
          _isLoading = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Gagal memuat data tagihan';
        _isLoading = false;
      });
    }
  }

  void _setupRealtimeListener() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    _supabase
        .channel('split_bill_changes_${userId.substring(0, 8)}')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'split_bills',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            print('Realtime update received: $payload'); // Debug logging
            if (mounted) _loadBills();
          },
        )
        .subscribe();
  }

  Future<void> _deleteBill(String billId) async {
    try {
      await _supabase.from('split_bills').delete().eq('id', billId);

      // Refresh the list
      await _loadBills();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus tagihan: $e')));
    }
  }

  void _showAddBillDialog() {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController(
      text: DateFormat('d MMMM yyyy').format(DateTime.now()),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Tambah Tagihan Baru',
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
                    labelText: 'Nama',
                    labelStyle: GoogleFonts.plusJakartaSans(),
                  ),
                ),
                const Gap(10),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nominal',
                    labelStyle: GoogleFonts.plusJakartaSans(),
                  ),
                ),
                const Gap(10),
                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      dateController.text = DateFormat(
                        'd MMMM yyyy',
                      ).format(selectedDate);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
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
                  final amount = double.tryParse(amountController.text) ?? 0;
                  final date = dateController.text;

                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nama tidak boleh kosong')),
                    );
                    return;
                  }

                  if (amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nominal harus lebih dari 0'),
                      ),
                    );
                    return;
                  }

                  try {
                    await _supabase.from('split_bills').insert({
                      'user_id': _supabase.auth.currentUser?.id,
                      'name': name,
                      'amount': amount,
                      'date': date,
                    });

                    if (!mounted) return;

                    // Panggil _loadBills() setelah data berhasil disimpan
                    await _loadBills();
                    Navigator.pop(context);
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menambah tagihan: $e')),
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
                          'Split bill',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),

                    // Error Message
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: GoogleFonts.plusJakartaSans(color: Colors.red),
                      ),

                    // Loading Indicator
                    if (_isLoading) const CircularProgressIndicator(),

                    // Bills List
                    Expanded(
                      child:
                          _bills.isEmpty && !_isLoading
                              ? Center(
                                child: Text(
                                  'Belum ada tagihan',
                                  style: GoogleFonts.plusJakartaSans(),
                                ),
                              )
                              : ListView.builder(
                                itemCount: _bills.length,
                                itemBuilder: (context, index) {
                                  final bill = _bills[index];
                                  return ListSplitbill(
                                    isName: bill['name'],
                                    isDate: bill['date'],
                                    isNominal: bill['amount'].toDouble(),
                                    onDeletePressed: () async {
                                      await _deleteBill(bill['id']);
                                    },
                                  );
                                },
                              ),
                    ),

                    const Gap(2),

                    GestureDetector(
                      onTap: _showAddBillDialog,
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
                            'Tambah Tagihan',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.putih,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
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
