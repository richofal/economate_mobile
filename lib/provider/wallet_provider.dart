// providers/wallet_provider.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wallet_model.dart';

class WalletProvider with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Wallet> _wallets = [];
  bool _isLoading = false;

  List<Wallet> get wallets => _wallets;
  bool get isLoading => _isLoading;

  Future<void> loadWallets() async {
    try {
      _isLoading = true;
      notifyListeners();

      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response = await _supabase
          .from('wallets')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      _wallets =
          (response as List).map((json) => Wallet.fromMap(json)).toList();
    } catch (e) {
      debugPrint('Error loading wallets: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _setupRealtimeListener() {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    _supabase
        .channel('wallet_changes_$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'wallets',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) => loadWallets(),
        )
        .subscribe();
  }

  // Di dalam class WalletProvider

  Future<void> updateWalletBalance({
    required String walletId,
    required double amount,
  }) async {
    try {
      await _supabase.rpc(
        'update_wallet_balance',
        params: {'wallet_id': walletId, 'amount': amount},
      );

      // Reload wallets setelah update
      await loadWallets();
    } catch (e) {
      debugPrint('Error updating wallet balance: $e');
      rethrow;
    }
  }
}
