import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisely/core/database/DataBase.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'package:wisely/features/categorise/domain/riverpod/CategoryProvider.dart';

abstract class CategoryDb {
  Future<bool> addCategoryDb(WidgetRef ref, Category e);
  Future<bool> deleteCategory(WidgetRef ref, Category e);
  Future<bool> isExist(Category c);
  Future<bool> editCategory(WidgetRef ref, Category newC, Category oldC);
  Future<List<Category>> getCategories();
  Future<void> categoryChangemnt(Category? oldC, Category? newC, WidgetRef ref);
  Future<Category?> getCategory(String? c);
}

class CategoryDb_impl implements CategoryDb {
  @override
  Future<bool> addCategoryDb(WidgetRef ref, Category c) async {
    try {
      await DatabaseHelper.database!.insert('category', c.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      ref.read(categoryProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      print("error in inserting into Categories \n error : ${e.toString()}");
      return false;
    }
  }

  @override
  Future<void> categoryChangemnt(
      Category? oldC, Category? newC, WidgetRef ref) {
    // TODO: implement categoryChangemnt
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCategory(WidgetRef ref, Category e) async {
    try {
      await DatabaseHelper.opendatabase();
      await DatabaseHelper.database!
          .delete('category', where: "id = ?", whereArgs: [e.id]);
      ref.read(categoryProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      print("error in deleting category error : ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> editCategory(WidgetRef ref, Category newC, Category oldC) {
    // TODO: implement editCategory
    throw UnimplementedError();
  }

  @override
  Future<Category?> getCategory(String? c) async {
    if (c == null) {
      return null;
    }
    List<Map<String, dynamic>> result = await DatabaseHelper.database!
        .query('category', where: 'id = ?', whereArgs: [c]);
    if (result.isNotEmpty) {
      return Category.fromMap(result[0]);
    }
    return null;
  }

  @override
  Future<List<Category>> getCategories() async {
    await DatabaseHelper.opendatabase();
    List<Map<String, dynamic>> categoryMap =
        await DatabaseHelper.database!.query('category');

    print("this is the categories $categoryMap");
    //generate a list from the map
    return List.generate(
        categoryMap.length,
        (index) => Category.withId(
              id: categoryMap[index]['id'] as String,
              title: categoryMap[index]['title'] as String,
              amount: categoryMap[index]['amount'] as int,
              icon: categoryMap[index]['icon'] as int?,
            ));
  }

  @override
  Future<bool> isExist(Category c) {
    // TODO: implement isExist
    throw UnimplementedError();
  }
}
