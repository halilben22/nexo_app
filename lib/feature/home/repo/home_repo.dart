import 'package:nexo_app/auth/auth_service.dart';
import 'package:nexo_app/firebase/firebase_service.dart';
import 'package:nexo_app/models/account_model.dart';
import 'package:nexo_app/models/transaction_model.dart';

class HomeRepository {
  final _firestore = FirebaseService().firestore;
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

  //Aylık toplam gelir ve gider hesaplanacak.
  //Bu kısımdan sonra date filtrelemesi yapılacak. Yani modellerde date....
  //ile alakalı kısımlar yeniden incelenecek.
}
