import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/models/transaction_model.dart';
import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:economate_mobile/provider/wallet_provider.dart';
import 'package:economate_mobile/widgets/dropdown_category.dart';
import 'package:economate_mobile/widgets/dropdown_insert.dart';
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

class Pemasukan extends StatefulWidget {
  const Pemasukan({super.key});

  @override
  State<Pemasukan> createState() => _PemasukanState();
}

class _PemasukanState extends State<Pemasukan> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedCategory;
  String? _selectedWallet;
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
                        'Pemasukan',
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
                        validator:
                            (value) =>
                                value?.isEmpty ?? true
                                    ? 'Judul harus diisi'
                                    : null,
                      ),
                      const Gap(24),

                      DropdownCategory(
                        isHint: 'Kategori',
                        isIncome: true,
                        items: const ['Gaji', 'Hadiah', 'Investasi', 'Lainnya'],
                        onChanged: (value) => _selectedCategory = value,
                        validator:
                            (value) => value == null ? 'Pilih kategori' : null,
                      ),
                      const Gap(24),

                      TextfieldInsert(
                        isHint: 'Nominal',
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value?.isEmpty ?? true)
                            return 'Nominal harus diisi';
                          if (double.tryParse(value!) == null)
                            return 'Masukkan angka yang valid';
                          if (double.parse(value) <= 0)
                            return 'Nominal harus lebih dari 0';
                          return null;
                        },
                      ),
                      const Gap(24),

                      DropdownWallet(
                        isHint: 'Wallet',
                        items:
                            walletProvider.wallets.map((w) => w.name).toList(),
                        values:
                            walletProvider.wallets.map((w) => w.id).toList(),
                        onChanged: (value) => _selectedWallet = value,
                        validator:
                            (value) => value == null ? 'Pilih wallet' : null,
                      ),
                      const Gap(24),

                      TextfieldInsert(
                        isHint: 'Tanggal',
                        controller: _dateController,
                        readOnly: true,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            setState(() {
                              _dateController.text = DateFormat(
                                'yyyy-MM-dd',
                              ).format(date);
                            });
                          }
                        },
                      ),
                      const Gap(24),

                      ButtonInsert(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              final transaction = Transaction(
                                id: '', // ID akan di-generate oleh Supabase
                                userId: _supabase.auth.currentUser?.id ?? '',
                                title: _titleController.text,
                                category: _selectedCategory ?? '',
                                amount: double.parse(_amountController.text),
                                walletId: _selectedWallet ?? '',
                                date: DateTime.parse(_dateController.text),
                                isIncome: true,
                                createdAt: DateTime.now(),
                              );

                              final transactionProvider =
                                  Provider.of<TransactionProvider>(
                                    context,
                                    listen: false,
                                  );

                              await transactionProvider.addTransaction(
                                transaction,
                              );

                              // Update wallet balance
                              await _supabase.rpc(
                                'update_wallet_balance',
                                params: {
                                  'wallet_id': _selectedWallet,
                                  'amount': double.parse(
                                    _amountController.text,
                                  ),
                                },
                              );

                              if (mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Gagal menambah transaksi: $e',
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
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
