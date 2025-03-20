import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/model/transaction.dart';
import 'package:newzenalphatech/repository/transaction/transaction_repo.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;
  TransactionBloc(this.repository) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }
  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final transactions = repository.getAllTransactions();
      emit(TransactionLoadSuccess(transactions));
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await repository.addTransaction(event.transaction);
      final transactions = repository.getAllTransactions();
      emit(TransactionLoadSuccess(transactions));
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }

  Future<void> _onUpdateTransaction(
    UpdateTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await repository.updateTransaction(event.transaction);
      final transactions = repository.getAllTransactions();
      emit(TransactionLoadSuccess(transactions));
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await repository.deleteTransaction(event.transactionId);
      final transactions = repository.getAllTransactions();
      emit(TransactionLoadSuccess(transactions));
    } catch (e) {
      emit(TransactionFailure(e.toString()));
    }
  }
}
