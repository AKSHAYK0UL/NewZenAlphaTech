import 'package:hive/hive.dart';
import 'package:newzenalphatech/model/transaction.dart';

class TransactionRepository {
  final Box<Transaction> transactionBox;

  TransactionRepository(this.transactionBox);

  Future<void> addTransaction(Transaction transaction) async {
    await transactionBox.put(transaction.id, transaction);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await transactionBox.put(transaction.id, transaction);
  }

  Future<void> deleteTransaction(String id) async {
    await transactionBox.delete(id);
  }

  List<Transaction> getAllTransactions() {
    return transactionBox.values.toList();
  }

  List<Transaction> getTransactionsByDate(DateTime start, DateTime end) {
    return transactionBox.values
        .where((t) => t.date.isAfter(start) && t.date.isBefore(end))
        .toList();
  }
}
