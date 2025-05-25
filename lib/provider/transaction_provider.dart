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

      _transactions = (response as List)
          .map((json) => Transaction.fromMap(json))
          .toList();
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
      await _supabase.from('transactions').insert(transaction.toMap());
      await loadTransactions(); // Reload data setelah menambah
    } catch (e) {
      debugPrint('Error adding transaction: $e');
      rethrow;
    }
  }

  void _setupRealtimeListener() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    _supabase
        .channel('transaction_changes_$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'transactions',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) => loadTransactions(),
        )
        .subscribe();
  }

  @override
  void dispose() {
    _supabase.removeAllChannels();
    super.dispose();
  }
}