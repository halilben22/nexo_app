import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String accountid;
  final double amount;
  final String title;

  final String category;

  final DateTime date;

  final DateTime createdAt;

  final DateTime updatedAt;

  final bool isExpense;
  TransactionModel({
    required this.id,
    required this.accountid,
    required this.amount,
    required this.title,
    required this.category,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.isExpense,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json["id"] as String,
      accountid: json["accountid"] as String,
      amount: (json["amount"] as num).toDouble(),
      title: json["title"] as String,
      category: json["category"] as String,
      date: DateTime.parse(json["date"] as String),
      isExpense: json["isExpense"] as bool,
      createdAt: DateTime.parse(json["createdAt"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "accountid": accountid,
      "amount": amount,
      "title": title,
      "category": category,
      "date": date,
      "isExpense": isExpense,
    };
  }
}
