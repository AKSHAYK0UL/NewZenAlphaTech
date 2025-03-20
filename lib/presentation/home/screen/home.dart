import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newzenalphatech/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:newzenalphatech/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:newzenalphatech/bloc/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:newzenalphatech/constant/constants.dart';
import 'package:newzenalphatech/core/enums/database_enum.dart';
import 'package:newzenalphatech/model/transaction.dart';

import 'package:newzenalphatech/presentation/home/widget/drawer.dart';
import 'package:newzenalphatech/presentation/home/widget/transaction_title.dart';
import 'package:newzenalphatech/presentation/transaction/screen/transaction_input.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = Hive.box<Transaction>(transactionBox);
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    context.read<DatabaseBloc>().add(GetDataEvent());
    context.read<TransactionBloc>().add(LoadTransactions());
    context.read<CategoryBloc>().add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BuildDrawer(),
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const TransactionFormModal(),
                );
              },
              icon: const Icon(
                Icons.add,
              )),
        ],
      ),
      body: BlocBuilder<DatabaseBloc, DatabaseState>(
        builder: (context, state) {
          if (state is DatabaseLoadingState &&
              state.loadingSource == DatabaseEnum.get) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box<Transaction> box, _) {
              if (box.values.isEmpty) {
                return const Center(child: Text('No Transactions Found'));
              }
              return ListView.builder(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  final transaction = box.getAt(index)!;
                  return TransactionTitle(
                    box: box,
                    index: index,
                    transaction: transaction,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
