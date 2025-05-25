// providers/transaction_provider.dart
import 'package:economate_mobile/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Transaction> _transactions = [];
  bool _isLoading = false;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;

  Future<void> loadTransactions() async {
    try {
      _isLoading = true;
      notifyListeners();

      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response = await _supabase
          .from('transactions')
          .select()
          .eq('user_id', userId)
          .order('date', ascending: false);

      _transactions =
          (response as List).map((json) => Transaction.fromMap(json)).toList();
    } catch (e) {
      debugPrint('Error loading transactions: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      await _supabase.from('transactions').insert({
        ...transaction.toMap(),
        'user_id': userId, // Pastikan user_id disertakan
      });

      await loadTransactions();
    } catch (e) {
      debugPrint('Error adding transaction: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _supabase.removeAllChannels();
    super.dispose();
  }
}
