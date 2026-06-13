import 'package:nexo_app/auth/auth_service.dart';

import 'package:nexo_app/helper/helpers.dart';
import 'package:nexo_app/models/account_model.dart';
import 'package:nexo_app/models/transaction_model.dart';

class HomeRepository {
  final _firestore = Helpers().firestore;
  final transactions = Helpers().getCollection("transactions");
  final currentUser = AuthService().currentUser;

  Future<TransactionModel> getAllTransactionsForUser() async {
    final snapshot = await _firestore
        .collection('transactions')
        .where('userId', isEqualTo: currentUser?.uid)
        .get();
    return TransactionModel.fromJson(snapshot.docs.first.data());
  }

  Future<double> getBalanceForUser() async {
    final snapshot = await _firestore
        .collection('accounts')
        .where('userId', isEqualTo: currentUser?.uid)
        .get();

    AccountModel _model = AccountModel.fromJson(snapshot.docs.first.data());

    return _model.balance;
  }

  //Brings the balance only for current month
  Future<double> getMonthlyBalance() async {
    final now = DateTime.now();

    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfNextMonth = DateTime(now.year, now.month + 1, 1);

    final snapshot = await transactions
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
    final snapshot = await transactions
        .where("userId", isEqualTo: currentUser)
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

    final snapshot = await transactions
        .where("userId", isEqualTo: currentUser)
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

    final snapshot = await transactions
        .where("userId", isEqualTo: currentUser)
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

  //Aylık toplam gelir ve gider hesaplanacak.
  //Bu kısımdan sonra date filtrelemesi yapılacak. Yani modellerde
  // date ile alakalı kısımlar yeniden incelenecek.
  //Performans için cache dahil edilecek. Yani transactions vb.. veriler
  // cache ile telefondan çekilip,veri üzerine yazılacak.
}
