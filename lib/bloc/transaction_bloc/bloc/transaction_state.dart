part of 'transaction_bloc.dart';

sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

final class TransactionLoadSuccess extends TransactionState {
  final List<Transaction> transactions;
  TransactionLoadSuccess(this.transactions);
}

final class TransactionOperationSuccess extends TransactionState {
  final String message;
  TransactionOperationSuccess(this.message);
}

final class TransactionFailure extends TransactionState {
  final String error;
  TransactionFailure(this.error);
}
