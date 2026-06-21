import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexo_app/models/transaction_model.dart';

class FirebaseRepo {
  final FirebaseFirestore firestore;
  FirebaseRepo(this.firestore);

  CollectionReference<Map<String, dynamic>> getCollection(String collection) {
    return firestore.collection(collection);
  }

  String createId() {
    return getCollection("transactions").doc().id;
  }
}
