import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/models/transaction_model.dart';
import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:economate_mobile/provider/wallet_provider.dart';
import 'package:economate_mobile/widgets/dropdown_category.dart';
import 'package:economate_mobile/widgets/button_insert.dart';
import 'package:economate_mobile/widgets/dropdown_wallet.dart';
import 'package:economate_mobile/widgets/textfield_insert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditPengeluaranPage extends StatefulWidget {
  final Transaction transaction;

  const EditPengeluaranPage({super.key, required this.transaction});

  @override
  State<EditPengeluaranPage> createState() => _EditPengeluaranPageState();
}

class _EditPengeluaranPageState extends State<EditPengeluaranPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedCategory;
  String? _selectedWallet;
  final SupabaseClient _supabase = Supabase.instance.client;
  double _originalAmount = 0;

  @override
  void initState() {
    super.initState();
    // Isi form dengan data transaksi yang ada
    _titleController.text = widget.transaction.title;
    _amountController.text = widget.transaction.amount.toString();
    _selectedCategory = widget.transaction.category;
    _selectedWallet = widget.transaction.walletId;
    _dateController.text = DateFormat('yyyy-MM-dd').format(widget.transaction.date);
    _originalAmount = widget.transaction.amount;
    
    // Load wallets saat init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WalletProvider>(context, listen: false).loadWallets();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstant.putihbiru,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Gap(36),
                      Text(
                        'Edit Pengeluaran',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.birumuda,
                        ),
                      ),
                      const Gap(16),

                      TextfieldInsert(
                        isHint: 'Judul',
                        controller: _titleController,
                        validator: (value) => value?.isEmpty ?? true ? 'Judul harus diisi' : null,
                      ),
                      const Gap(24),

                      DropdownCategory(
                        isHint: 'Kategori',
                        isIncome: false,
                        items: const [
                          'Makanan',
                          'Transportasi',
                          'Hiburan',
                          'Belanjaan',
                          'Pekerjaan',
                          'Pakaian',
                          'Olahraga',
                          'Lainnya',
                        ],
                        selectedValue: _selectedCategory,
                        onChanged: (value) => _selectedCategory = value,
                        validator: (value) => value == null ? 'Pilih kategori' : null,
                      ),
                      const Gap(24),

                      TextfieldInsert(
                        isHint: 'Nominal',
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true) return 'Nominal harus diisi';
                          if (double.tryParse(value!) == null) return 'Masukkan angka yang valid';
                          if (double.parse(value) <= 0) return 'Nominal harus lebih dari 0';
                          return null;
                        },
                      ),
                      const Gap(24),

                      DropdownWallet(
                        isHint: 'Wallet',
                        items: walletProvider.wallets.map((w) => w.name).toList(),
                        values: walletProvider.wallets.map((w) => w.id).toList(),
                        selectedValue: _selectedWallet,
                        onChanged: (value) => _selectedWallet = value,
                        validator: (value) => value == null ? 'Pilih wallet' : null,
                      ),
                      const Gap(24),

                      TextfieldInsert(
                        isHint: 'Tanggal',
                        controller: _dateController,
                        readOnly: true,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: widget.transaction.date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            setState(() {
                              _dateController.text = DateFormat('yyyy-MM-dd').format(date);
                            });
                          }
                        },
                      ),
                      const Gap(24),

                      ButtonInsert(
                        text: 'Update Pengeluaran',
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              final newAmount = double.parse(_amountController.text);
                              final difference = _originalAmount - newAmount; // Selisih untuk pengeluaran

                              final updatedTransaction = Transaction(
                                id: widget.transaction.id,
                                userId: widget.transaction.userId,
                                title: _titleController.text,
                                category: _selectedCategory ?? '',
                                amount: newAmount,
                                walletId: _selectedWallet ?? '',
                                date: DateTime.parse(_dateController.text),
                                isIncome: false,
                                createdAt: widget.transaction.createdAt,
                              );

                              final transactionProvider = Provider.of<TransactionProvider>(
                                context,
                                listen: false,
                              );

                              await transactionProvider.updateTransaction(updatedTransaction);

                              // Update wallet balance dengan selisih perubahan
                              await _supabase.rpc(
                                'update_wallet_balance',
                                params: {
                                  'wallet_id': _selectedWallet,
                                  'amount': difference,
                                },
                              );

                              if (mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Gagal mengupdate transaksi: $e'),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        backgroundColor: ColorConstant.birumuda,
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
                    colorFilter: ColorFilter.mode(
                      ColorConstant.birumuda,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}