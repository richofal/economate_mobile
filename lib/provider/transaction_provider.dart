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
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('transactions').update({
        'title': transaction.title,
        'category': transaction.category,
        'amount': transaction.amount,
        'wallet_id': transaction.walletId,
        'date': transaction.date.toIso8601String(),
        'is_income': transaction.isIncome,
      }).eq('id', transaction.id);

      // Update local data
      final index = _transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        _transactions[index] = transaction;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to update transaction: $e');
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('transactions').delete().eq('id', id);

      // Remove from local data
      _transactions.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete transaction: $e');
    }
  }

  @override
  void dispose() {
    _supabase.removeAllChannels();
    super.dispose();
  }
}
