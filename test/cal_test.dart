import 'package:flutter_test/flutter_test.dart';
import 'package:newzenalphatech/core/helper/calculation.dart';
import 'package:newzenalphatech/model/transaction.dart';

void main() {
  group('Transaction Calculations', () {
    final startDate = DateTime(2021, 1, 1);
    final endDate = DateTime(2021, 12, 31);

    final transactions = [
      Transaction(
        date: DateTime(2021, 2, 1),
        amount: 1000.0,
        isIncome: true,
        category: 'Salary',
        title: 'test',
      ),
      Transaction(
        date: DateTime(2021, 3, 1),
        amount: 500.0,
        isIncome: true,
        category: 'Bonus',
        title: 'test',
      ),
      Transaction(
        date: DateTime(2021, 4, 1),
        amount: -200.0,
        isIncome: false,
        category: 'Food',
        title: 'test',
      ),
      Transaction(
        date: DateTime(2021, 5, 1),
        amount: -300.0,
        isIncome: false,
        category: 'Transport',
        title: 'test',
      ),
      Transaction(
        date: DateTime(2020, 12, 31),
        amount: 100.0,
        isIncome: true,
        category: 'Salary',
        title: 'test',
      ),
      Transaction(
        date: DateTime(2022, 1, 1),
        amount: -50.0,
        isIncome: false,
        category: 'Food',
        title: 'test',
      ),
    ];

    test('calculateTotalIncome sums only incomes within the date range', () {
      final totalIncome =
          calculateTotalIncome(transactions, startDate, endDate);
      expect(totalIncome, equals(1500.0));
    });

    test('calculateTotalExpenses sums only expenses within the date range', () {
      final totalExpenses =
          calculateTotalExpenses(transactions, startDate, endDate);
      expect(totalExpenses, equals(500.0));
    });

    test('calculateNetBalance returns income minus expenses', () {
      final totalIncome =
          calculateTotalIncome(transactions, startDate, endDate);
      final totalExpenses =
          calculateTotalExpenses(transactions, startDate, endDate);
      final netBalance = calculateNetBalance(totalIncome, totalExpenses);
      expect(netBalance, equals(1000.0));
    });

    test('calculateSpendingByCategory groups expenses by category correctly',
        () {
      final spendingByCategory =
          calculateSpendingByCategory(transactions, startDate, endDate);

      expect(spendingByCategory.length, equals(2));
      expect(spendingByCategory['Food'], equals(200.0));
      expect(spendingByCategory['Transport'], equals(300.0));
    });
  });
}
