import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexo_app/auth/auth_service.dart';

import 'package:nexo_app/models/account_model.dart';
import 'package:nexo_app/models/transaction_model.dart';
import 'package:nexo_app/repo/firebase_repo.dart';

class HomeRepository {
  final AuthService authService;
  final FirebaseRepo firebaseRepo;
  User? get currentUser => authService.currentUser;
  HomeRepository({required this.authService, required this.firebaseRepo});

  Future<TransactionModel> getAllTransactionsForUser() async {
    final snapshot = await firebaseRepo
        .getCollection("transactions")
        .where('userId', isEqualTo: currentUser?.uid)
        .get();

    return TransactionModel.fromJson(snapshot.docs.first.data());
  }

  Future<double> getBalanceForUser() async {
    final snapshot = await firebaseRepo
        .getCollection("accounts")
        .where('userId', isEqualTo: currentUser?.uid)
        .get();

    AccountModel model = AccountModel.fromJson(snapshot.docs.first.data());

    return model.balance;
  }

  //Brings the balance only for current month
  Future<double> getMonthlyBalance() async {
    final now = DateTime.now();

    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfNextMonth = DateTime(now.year, now.month + 1, 1);

    final snapshot = await firebaseRepo
        .getCollection("transactions")
        .where('userId', isEqualTo: currentUser?.uid)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThan: startOfNextMonth)
        .get();

    double total = 0;

    for (final doc in snapshot.docs) {
      final data = TransactionModel.fromJson(doc.data());

      total += data.isExpense ? -data.amount : data.amount;
    }

    return total;
  }

  //Brings the balance within given dates
  Future<double> getBalanceByTimeFilter(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final snapshot = await firebaseRepo
        .getCollection("transactions")
        .where("userId", isEqualTo: currentUser?.uid)
        .where("date", isGreaterThanOrEqualTo: startDate)
        .where("date", isLessThanOrEqualTo: endDate)
        .get();

    double total = 0;
    for (final doc in snapshot.docs) {
      final data = TransactionModel.fromJson(doc.data());
      total += data.isExpense ? -data.amount : data.amount;
    }

    return total;
    // --> 12.03.2025-25.05.2025
  }

  Future<double> getMonthlyIncome() async {
    final now = DateTime.now();

    final startMonth = DateTime(now.year, now.month, 1);
    final endMonth = DateTime(now.year, now.month + 1, 1);

    final snapshot = await firebaseRepo
        .getCollection("transactions")
        .where("userId", isEqualTo: currentUser?.uid)
        .where("date", isGreaterThanOrEqualTo: startMonth)
        .where("date", isLessThan: endMonth)
        .get();

    double total = 0;

    for (final doc in snapshot.docs) {
      final data = TransactionModel.fromJson(doc.data());
      total += !(data.isExpense) ? data.amount : 0;
    }

    return total;
  }

  Future<double> getMonthlyExpense() async {
    final now = DateTime.now();

    final startMonth = DateTime(now.year, now.month, 1);
    final endMonth = DateTime(now.year, now.month + 1, 1);

    final snapshot = await firebaseRepo
        .getCollection("transactions")
        .where("userId", isEqualTo: currentUser?.uid)
        .where("date", isGreaterThanOrEqualTo: startMonth)
        .where("date", isLessThan: endMonth)
        .get();

    double total = 0;

    for (final doc in snapshot.docs) {
      final data = TransactionModel.fromJson(doc.data());
      total += data.isExpense ? -(data.amount) : 0;
    }

    return total;
  }

  Future<void> addIncome(TransactionModel transaction_model) async {
    try {
      await firebaseRepo
          .getCollection("users")
          .doc(currentUser?.uid)
          .collection("transactions")
          .add(transaction_model.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  //Aylık toplam gelir ve gider hesaplanacak.
  //Bu kısımdan sonra date filtrelemesi yapılacak. Yani modellerde
  // date ile alakalı kısımlar yeniden incelenecek.
  //Performans için cache dahil edilecek. Yani transactions vb.. veriler
  // cache ile telefondan çekilip,veri üzerine yazılacak.
}
