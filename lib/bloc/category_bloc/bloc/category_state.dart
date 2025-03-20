part of 'category_bloc.dart';

sealed class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final List<Category> categories;
  CategoryLoadSuccess(this.categories);
}

class CategoryFailure extends CategoryState {
  final String error;
  CategoryFailure(this.error);
}
