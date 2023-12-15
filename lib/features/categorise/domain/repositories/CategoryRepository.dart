import 'package:wisely/features/categorise/domain/entities/category.dart';

abstract class CategoryRepository {
  //add category
  Future<bool> addCategory(Category c);
  //delete category
  Future<bool> deleteCategory(Category c);
  //edit repository
  Future<Category> editCategory(Category c);
}
