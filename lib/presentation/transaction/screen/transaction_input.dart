import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:newzenalphatech/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:newzenalphatech/model/transaction.dart';

class TransactionFormModal extends StatefulWidget {
  const TransactionFormModal({super.key});

  @override
  State<TransactionFormModal> createState() => _TransactionFormModalState();
}

class _TransactionFormModalState extends State<TransactionFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isIncome = true;
  bool _isRecurring = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Transaction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
              // Amount Field
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter an amount' : null,
              ),
              const SizedBox(height: 16),
              // Category Field
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoadSuccess &&
                      state.categories.isNotEmpty) {
                    return DropdownButtonFormField<String>(
                      value: state.categories.first.name,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: state.categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.name,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _categoryController.text = value ?? '';
                        });
                      },
                    );
                  }
                  // Fallback to a text input if no categories are defined
                  return TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter a category'
                        : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              // Date Picker
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
              // Income/Expense Switch
              SwitchListTile(
                title: const Text('Is Income'),
                value: _isIncome,
                onChanged: (val) {
                  setState(() {
                    _isIncome = val;
                  });
                },
              ),
              // Recurring Checkbox
              CheckboxListTile(
                title: const Text('Is Recurring'),
                value: _isRecurring,
                onChanged: (val) {
                  setState(() {
                    _isRecurring = val ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Add Transaction'),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newTransaction = Transaction(
                      title: _titleController.text,
                      amount: double.tryParse(_amountController.text) ?? 0.0,
                      date: _selectedDate,
                      category: _categoryController.text,
                      isIncome: _isIncome,
                      isRecurring: _isRecurring,
                    );

                    context
                        .read<DatabaseBloc>()
                        .add(AddDataEvent(data: newTransaction));

                    if (!context.mounted) return;
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
