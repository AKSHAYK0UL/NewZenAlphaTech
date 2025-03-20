import 'package:cloud_firestore/cloud_firestore.dart';

const String usersCollection = "users";

class DatabaseNetwork {
  late final FirebaseFirestore _firestoreInstance;
  late final String _userId;
  late final CollectionReference _usersCollection;

  DatabaseNetwork(
      {required FirebaseFirestore firestoreInstance, required String userId}) {
    _firestoreInstance = firestoreInstance;
    _userId = userId;
    _usersCollection = _firestoreInstance
        .collection(_userId)
        .doc("Transaction")
        .collection("Data");
  }

  Future<void> addData(Map<String, dynamic> data) async {
    try {
      await _usersCollection.add(data);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<QuerySnapshot<Object?>> getData() async {
    try {
      return await _usersCollection.get();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      QuerySnapshot snapshot =
          await _usersCollection.where('id', isEqualTo: id).get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      } else {
        throw Exception("No document found with the given id.");
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
