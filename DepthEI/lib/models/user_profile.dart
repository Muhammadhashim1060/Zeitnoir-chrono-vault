class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String country;
  final String currency;
  final String level;
  final double walletBalance;
  final double totalDebt;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.country,
    required this.currency,
    required this.level,
    required this.walletBalance,
    required this.totalDebt,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'country': country,
        'currency': currency,
        'level': level,
        'wallet_balance': walletBalance,
        'total_debt': totalDebt,
      };

  factory UserProfile.fromMap(String uid, Map<String, dynamic> map) => UserProfile(
        uid: uid,
        name: (map['name'] ?? '') as String,
        email: (map['email'] ?? '') as String,
        country: (map['country'] ?? '') as String,
        currency: (map['currency'] ?? 'USD') as String,
        level: (map['level'] ?? 'Debt Fighter') as String,
        walletBalance: (map['wallet_balance'] ?? 0).toDouble(),
        totalDebt: (map['total_debt'] ?? 0).toDouble(),
      );
}
