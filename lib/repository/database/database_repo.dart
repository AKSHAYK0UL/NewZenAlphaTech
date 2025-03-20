import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:newzenalphatech/constant/constants.dart';
import 'package:newzenalphatech/model/transaction.dart' as tt;
import 'package:newzenalphatech/network/database/database_network.dart';

class DatabaseRepo {
  final DatabaseNetwork _databaseNetwork;

  DatabaseRepo({required DatabaseNetwork databaseNetwork})
      : _databaseNetwork = databaseNetwork;

  Future<void> addData(tt.Transaction data) async {
    try {
      final jsonData = data.toJson();
      await _databaseNetwork.addData(jsonData);
      await _updateHiveData(data);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<tt.Transaction>> getData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final snapshot = await _databaseNetwork.getData();
        if (snapshot.docs.isNotEmpty) {
          final transactions = snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return tt.Transaction.fromJson(data);
          }).toList();
          for (var transaction in transactions) {
            await _updateHiveData(transaction);
          }
          return transactions;
        } else {
          throw Exception("No data found online");
        }
      } catch (e) {
        return await _getHiveData();
      }
    } else {
      return await _getHiveData();
    }
  }

  Future<void> delete(String id, int index) async {
    try {
      await _databaseNetwork.delete(id);
      await _deleteHiveData(index);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<tt.Transaction>> _getHiveData() async {
    final box = Hive.box<tt.Transaction>(transactionBox);
    if (box.isNotEmpty) {
      return box.values.toList();
    } else {
      throw Exception("No local data available");
    }
  }

  Future<void> _updateHiveData(tt.Transaction transaction) async {
    final box = Hive.box<tt.Transaction>(transactionBox);
    await box.put(transaction.id, transaction);
  }

  Future<void> _deleteHiveData(int index) async {
    final box = Hive.box<tt.Transaction>(transactionBox);
    await box.deleteAt(index);
  }
}
