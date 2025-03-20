import 'package:newzenalphatech/model/transaction.dart';

double calculateTotalIncome(
    List<Transaction> transactions, DateTime startDate, DateTime endDate) {
  return transactions
      .where((tx) =>
          tx.isIncome &&
          !tx.date.isBefore(startDate) &&
          !tx.date.isAfter(endDate))
      .fold(0.0, (sum, tx) => sum + tx.amount);
}

double calculateTotalExpenses(
    List<Transaction> transactions, DateTime startDate, DateTime endDate) {
  return transactions
      .where((tx) =>
          !tx.isIncome &&
          !tx.date.isBefore(startDate) &&
          !tx.date.isAfter(endDate))
      .fold(0.0, (sum, tx) => sum + tx.amount.abs());
}

double calculateNetBalance(double totalIncome, double totalExpenses) {
  return totalIncome - totalExpenses;
}

Map<String, double> calculateSpendingByCategory(
    List<Transaction> transactions, DateTime startDate, DateTime endDate) {
  Map<String, double> spendingByCategory = {};
  for (var tx in transactions) {
    if (!tx.isIncome &&
        !tx.date.isBefore(startDate) &&
        !tx.date.isAfter(endDate)) {
      double expense = tx.amount.abs();
      spendingByCategory.update(tx.category, (value) => value + expense,
          ifAbsent: () => expense);
    }
  }

  return spendingByCategory;
}
