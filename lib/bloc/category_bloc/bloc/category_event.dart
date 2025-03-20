part of 'category_bloc.dart';

sealed class CategoryEvent {}

final class LoadCategories extends CategoryEvent {}

final class AddCategory extends CategoryEvent {
  final Category category;
  AddCategory(this.category);
}

final class UpdateCategory extends CategoryEvent {
  final Category category;
  UpdateCategory(this.category);
}

final class DeleteCategory extends CategoryEvent {
  final String categoryId;
  DeleteCategory(this.categoryId);
}
