import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String userId;
  final String title;
  final String category;
  final double amount;
  final String walletId;
  final DateTime date;
  final bool isIncome;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.title,
    required this.category,
    required this.amount,
    required this.walletId,
    required this.date, // Hanya tanggal (tanpa waktu)
    required this.isIncome,
    required this.createdAt,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      walletId: map['wallet_id'] ?? '',
      date: map['date'] != null 
          ? DateTime.parse(map['date']) 
          : DateTime.now(), // Fallback if null
      isIncome: map['is_income'] ?? false,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'category': category,
      'amount': amount,
      'wallet_id': walletId,
      'date': DateFormat('yyyy-MM-dd').format(date), // Format ke DATE
      'is_income': isIncome,
    };
  }
}