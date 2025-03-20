part of 'database_bloc.dart';

sealed class DatabaseEvent {}

final class AddDataEvent extends DatabaseEvent {
  final Transaction data;

  AddDataEvent({required this.data});
}

final class GetDataEvent extends DatabaseEvent {}

final class DeleteDataEvent extends DatabaseEvent {
  final String id;
  final int index;

  DeleteDataEvent({required this.id, required this.index});
}
