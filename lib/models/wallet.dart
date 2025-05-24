class Wallet {
  final String id;
  final String userId;
  final String name;
  final double balance;
  final DateTime createdAt;
  
  Wallet({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.createdAt,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'balance': balance,
      'created_at': createdAt.toIso8601String(),
    };
  }
  
  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      name: map['name'] ?? '',
      balance: map['balance']?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}