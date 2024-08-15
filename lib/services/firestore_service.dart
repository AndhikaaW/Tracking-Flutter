import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _fire = FirebaseFirestore.instance;

  Future<void> create() async {
    try {
      await _fire.collection("users").add({
        "name": "aku",
        "age": 20
      });
    } catch (e) {
      log(e.toString());
    }
  }
}