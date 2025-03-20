import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class FinancialOverviewDashboard extends StatelessWidget {
  final double totalIncome;
  final double totalExpenses;
  final double netBalance;
  final Map<String, double> spendingByCategory;

  const FinancialOverviewDashboard({
    super.key,
    required this.totalIncome,
    required this.totalExpenses,
    required this.netBalance,
    required this.spendingByCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMetricCard('Total Income', totalIncome, Colors.green),
          _buildMetricCard('Total Expenses', totalExpenses, Colors.red),
          _buildMetricCard(
            'Net Balance',
            netBalance,
            netBalance >= 0 ? Colors.blue : Colors.orange,
          ),
          const SizedBox(height: 20),
          spendingByCategory.isNotEmpty
              ? PieChart(
                  dataMap: spendingByCategory,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: _chartColors,
                  initialAngleInDegree: 0,
                  chartType: ChartType.disc,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    decimalPlaces: 1,
                  ),
                )
              : const Text('No expense data available'),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, double amount, Color color) {
    return Card(
      color: Colors.blueGrey.shade100,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _chartColors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.tealAccent,
    Colors.amber,
    Colors.deepPurple,
  ];
}
