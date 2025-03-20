import 'package:hive/hive.dart';
import 'package:newzenalphatech/model/category.dart';

class CategoryRepository {
  final Box<Category> categoryBox;

  CategoryRepository(this.categoryBox);

  Future<void> addCategory(Category category) async {
    await categoryBox.put(category.id, category);
  }

  Future<void> updateCategory(Category category) async {
    await categoryBox.put(category.id, category);
  }

  Future<void> deleteCategory(String id) async {
    await categoryBox.delete(id);
  }

  List<Category> getAllCategories() {
    return categoryBox.values.toList();
  }
}
