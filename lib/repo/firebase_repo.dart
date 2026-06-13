import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepo {
  final FirebaseFirestore firestore;
  FirebaseRepo(this.firestore);

  CollectionReference<Map<String, dynamic>> getCollection(String collection) {
    return firestore.collection(collection);
  }
}
