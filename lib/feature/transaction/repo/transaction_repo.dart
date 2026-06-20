import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexo_app/auth/auth_service.dart';
import 'package:nexo_app/models/transaction_model.dart';
import 'package:nexo_app/repo/firebase_repo.dart';

class TransactionRepo {
  final AuthService authService;
  final FirebaseRepo firebaseRepo;
  User? get currentUser => authService.currentUser;
  TransactionRepo({required this.firebaseRepo, required this.authService});

  Future<void> addTransaction(TransactionModel transaction_model) async {
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
}
