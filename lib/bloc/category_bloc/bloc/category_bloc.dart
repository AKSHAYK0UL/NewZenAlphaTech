import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/model/category.dart';
import 'package:newzenalphatech/repository/category/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final categories = repository.getAllCategories();
      emit(CategoryLoadSuccess(categories));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }

  Future<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await repository.addCategory(event.category);
      final categories = repository.getAllCategories();
      emit(CategoryLoadSuccess(categories));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await repository.updateCategory(event.category);
      final categories = repository.getAllCategories();
      emit(CategoryLoadSuccess(categories));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await repository.deleteCategory(event.categoryId);
      final categories = repository.getAllCategories();
      emit(CategoryLoadSuccess(categories));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }
}
