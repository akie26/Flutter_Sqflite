import 'package:MyTodoList/models/Category.dart';
import 'package:MyTodoList/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  readCategory() async {
    return await _repository.readData('categories');
  }

  readCategoryById(categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }

  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  deleteCategory(categoryId) async {
    return await _repository.deleteDataById('categories', categoryId);
  }
}
