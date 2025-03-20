import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newzenalphatech/core/helper/calculation.dart';
import 'package:newzenalphatech/model/transaction.dart';
import 'package:newzenalphatech/presentation/dashboard/widget/dashboard.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = "dashboard";
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionBox = Hive.box<Transaction>('transactions');

    return Scaffold(
      appBar: AppBar(title: const Text('Financial Overview')),
      body: ValueListenableBuilder(
        valueListenable: transactionBox.listenable(),
        builder: (context, Box<Transaction> box, _) {
          List<Transaction> transactions = box.values.toList();

          DateTime now = DateTime.now();
          DateTime startOfMonth = DateTime(now.year, now.month, 1);
          DateTime endOfMonth =
              DateTime(now.year, now.month + 1, 0, 23, 59, 59);

          double totalIncome =
              calculateTotalIncome(transactions, startOfMonth, endOfMonth);
          double totalExpenses =
              calculateTotalExpenses(transactions, startOfMonth, endOfMonth);
          double netBalance = calculateNetBalance(totalIncome, totalExpenses);
          Map<String, double> spendingByCategory = calculateSpendingByCategory(
              transactions, startOfMonth, endOfMonth);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: FinancialOverviewDashboard(
              totalIncome: totalIncome,
              totalExpenses: totalExpenses,
              netBalance: netBalance,
              spendingByCategory: spendingByCategory,
            ),
          );
        },
      ),
    );
  }
}
