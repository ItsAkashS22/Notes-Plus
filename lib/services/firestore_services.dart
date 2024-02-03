import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> create(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(documentId).set(data);
      return true;
    } catch (e) {
      log("FirestoreDatabaseError", error: e);
      return false;
    }
  }

  Future<QuerySnapshot?> read(
    String collection, {
    FutureOr<void> Function(Query)? settings,
  }) async {
    try {
      Query query = _firestore.collection(collection);
      if (settings != null) {
        await settings(query);
      }
      return await query.get();
    } catch (e) {
      log("FirestoreDatabaseError", error: e);
      return null;
    }
  }

  Future<bool> update(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(data);
      return true;
    } catch (e) {
      log("FirestoreDatabaseError", error: e);
      return false;
    }
  }

  Future<bool> delete(
    String collection,
    String documentId,
  ) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
      return true;
    } catch (e) {
      log("FirestoreDatabaseError", error: e);
      return false;
    }
  }
}
