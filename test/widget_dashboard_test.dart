import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newzenalphatech/presentation/dashboard/widget/dashboard.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  group('FinancialOverviewDashboard Widget Tests', () {
    testWidgets(
        'displays metric cards and PieChart when spending data is provided',
        (WidgetTester tester) async {
      final spendingData = {
        'Food': 150.0,
        'Rent': 800.0,
        'Entertainment': 200.0,
      };

      await tester.pumpWidget(
        MaterialApp(
          home: FinancialOverviewDashboard(
            totalIncome: 3000.0,
            totalExpenses: 1500.0,
            netBalance: 1500.0,
            spendingByCategory: spendingData,
          ),
        ),
      );

      expect(find.text('Total Income'), findsOneWidget);
      expect(find.text('Total Expenses'), findsOneWidget);
      expect(find.text('Net Balance'), findsOneWidget);

      expect(find.text('\$3000.00'), findsOneWidget);
      expect(find.text('\$1500.00'), findsNWidgets(2));

      expect(find.byType(PieChart), findsOneWidget);
    });

    testWidgets('displays fallback text when spending data is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: FinancialOverviewDashboard(
            totalIncome: 3000.0,
            totalExpenses: 1500.0,
            netBalance: 1500.0,
            spendingByCategory: {},
          ),
        ),
      );

      expect(find.text('No expense data available'), findsOneWidget);
      expect(find.byType(PieChart), findsNothing);
    });
  });
}
