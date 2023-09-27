import 'package:wisely/features/categorise/domain/entitties/categoryy.dart';

abstract class CategoryRepository {
  //add category
  Future<bool> addCategory(Category c);
  //delete category
  Future<bool> deleteCategory(Category c);
  //edit repository
  Future<Category> editCategory(Category c);
}
