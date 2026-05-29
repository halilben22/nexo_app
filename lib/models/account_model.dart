class AccountModel {
  final String id;

  final String name;

  final AccountType type;

  final double balance;

  final String currency;

  final DateTime createdAt;

  AccountModel({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.currency,
    required this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as AccountType,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "balance": balance,
      "currency": currency,
      "createdAt": createdAt,
    };
  }
}

enum AccountType { cash, bank, creditCard, savings, investment }
