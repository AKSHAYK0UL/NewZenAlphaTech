import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newzenalphatech/bloc/database_bloc/bloc/database_bloc.dart';

import 'package:newzenalphatech/model/transaction.dart';

class TransactionTitle extends StatelessWidget {
  final Transaction transaction;
  final Box<Transaction> box;
  final int index;
  const TransactionTitle({
    super.key,
    required this.transaction,
    required this.box,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: ListTile(
        tileColor: const Color.fromARGB(255, 222, 226, 228),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(transaction.title),
        subtitle: Text(
          "${transaction.isIncome ? 'Income' : 'Expense'} - \$${transaction.amount.toStringAsFixed(2)}\n"
          "Category: ${transaction.category}\n"
          "Date: ${transaction.date.toLocal().toString().split(' ')[0]}",
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text(
                    "Are you sure you want to delete this transaction"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      context.read<DatabaseBloc>().add(
                          DeleteDataEvent(id: transaction.id, index: index));
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
