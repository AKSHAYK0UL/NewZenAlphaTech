import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/core/enums/database_enum.dart';
import 'package:newzenalphatech/model/transaction.dart';
import 'package:newzenalphatech/repository/database/database_repo.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepo _databaseRepo;
  DatabaseBloc(this._databaseRepo) : super(DatabaseInitial()) {
    on<AddDataEvent>(_addData);
    on<GetDataEvent>(_getData);
    on<DeleteDataEvent>(_deleteData);
  }
  Future<void> _addData(AddDataEvent event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoadingState(loadingSource: DatabaseEnum.add));
    try {
      await _databaseRepo.addData(event.data);
      emit(DatabaseSuccessState(successSource: DatabaseEnum.add));
    } catch (e) {
      emit(DatabaseErrorState(
          errorMessage: e.toString(), errorSource: DatabaseEnum.add));
    }
  }

  Future<void> _getData(GetDataEvent event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoadingState(loadingSource: DatabaseEnum.get));
    try {
      final data = await _databaseRepo.getData();

      emit(DataState(data: data, dataSource: DatabaseEnum.get));
    } catch (e) {
      emit(DatabaseErrorState(
          errorMessage: e.toString(), errorSource: DatabaseEnum.get));
    }
  }

  Future<void> _deleteData(
      DeleteDataEvent event, Emitter<DatabaseState> emit) async {
    try {
      await _databaseRepo.delete(event.id, event.index);
    } catch (e) {
      emit(DatabaseErrorState(
          errorMessage: e.toString(), errorSource: DatabaseEnum.delete));
    }
  }
}
