import 'package:cloud_firestore/cloud_firestore.dart';

class Helpers {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> getCollection(String collection) {
    return firestore.collection(collection);
  }
}
