import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _fire = FirebaseFirestore.instance;

  Future<void> create({required String name,required int age}) async {
    try {
      await _fire.collection("users").add({
        "name": name,
        "age": age
      });
    } catch (e) {
      log(e.toString());
    }
  }
  Future<List<QueryDocumentSnapshot>> read() async {
    try {
      QuerySnapshot querySnapshot = await _fire.collection("users").get();
      return querySnapshot.docs;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
  Future<void> update({required String documentId, required String name, required int age}) async {
    try {
      await _fire.collection("users").doc(documentId).update({
        "name": name,
        "age": age
      });
      print("Document successfully updated!");
    } catch (e) {
      print("Error updating document: $e");
      log(e.toString());
    }
  }
  Future<void> delete(String documentId) async {
    try {
      await _fire.collection("users").doc(documentId).delete();
      print("Document successfully deleted!");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

}