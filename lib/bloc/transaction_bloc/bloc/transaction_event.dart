part of 'transaction_bloc.dart';

sealed class TransactionEvent {}

final class LoadTransactions extends TransactionEvent {}

final class AddTransaction extends TransactionEvent {
  final Transaction transaction;
  AddTransaction(this.transaction);
}

final class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;
  UpdateTransaction(this.transaction);
}

final class DeleteTransaction extends TransactionEvent {
  final String transactionId;
  DeleteTransaction(this.transactionId);
}
