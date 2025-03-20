import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:newzenalphatech/model/category.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = "/category";
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(LoadCategories());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoadSuccess) {
            if (state.categories.isEmpty) {
              return const Center(child: Text("No categories found"));
            }
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return ListTile(
                  title: Text(category.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Edit category
                          showDialog(
                            context: context,
                            builder: (context) {
                              final _editController =
                                  TextEditingController(text: category.name);
                              return AlertDialog(
                                title: const Text('Edit Category'),
                                content: TextField(
                                  controller: _editController,
                                  decoration: const InputDecoration(
                                      labelText: 'Category Name'),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final updatedCategory = Category(
                                        id: category.id,
                                        name: _editController.text,
                                      );
                                      context
                                          .read<CategoryBloc>()
                                          .add(UpdateCategory(updatedCategory));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<CategoryBloc>()
                              .add(DeleteCategory(category.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is CategoryFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new category
          showDialog(
            context: context,
            builder: (context) {
              final _nameController = TextEditingController();
              return AlertDialog(
                title: const Text('Add Category'),
                content: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Category Name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final newCategory = Category(name: _nameController.text);
                      context
                          .read<CategoryBloc>()
                          .add(AddCategory(newCategory));
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
