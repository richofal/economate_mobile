// services/supabase_wallet_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/models/wallet_model.dart';

class SupabaseWalletService {
  final SupabaseClient _supabase;

  SupabaseWalletService(this._supabase);

  Future<List<Wallet>> getWallets() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _supabase
        .from('wallets')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((json) => Wallet.fromMap(json)).toList();
  }

  Future<void> addWallet(Wallet wallet) async {
    await _supabase.from('wallets').insert(wallet.toMap());
  }

  Future<void> updateWallet(Wallet wallet) async {
    await _supabase.from('wallets').update(wallet.toMap()).eq('id', wallet.id);
  }

  Future<void> deleteWallet(String walletId) async {
    await _supabase.from('wallets').delete().eq('id', walletId);
  }

  Future<double> getTotalBalance() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return 0.0;

    final response = await _supabase
        .from('wallets')
        .select('balance')
        .eq('user_id', userId);

    return (response as List).fold<double>(
      0.0,
      (sum, wallet) => sum + ((wallet['balance'] as num).toDouble()),
    );
  }
}
