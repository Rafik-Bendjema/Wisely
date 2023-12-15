import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'package:wisely/features/categorise/domain/riverpod/CategoryProvider.dart';

abstract class CategoryDb {
  Future<Box<Category>?> openBox();
  Future<bool> addCategoryDb(WidgetRef ref, Category e);
  Future<bool> deleteCategory(WidgetRef ref, Category e);
  Future<void> getAllCategories(WidgetRef ref);
  Future<bool> isExist(Category c);
  Future<bool> editCategory(WidgetRef ref, Category newC, Category oldC);
  Future<void> editCategoryValue(
      WidgetRef ref, Category category, double amount);
  Future<List<Category>> getCategories();
  Future<void> CategoryChangemnt(Category? oldC, Category? newC, WidgetRef ref);
}

class CategoryDbImpl implements CategoryDb {
  @override
  Future<bool> addCategoryDb(WidgetRef ref, Category c) async {
    try {
      Box<Category>? b = await openBox();
      if (b == null) {
        //to implement an error handling
        print("error in adding a category");
        return false;
      }
      await b.put(c.id, c);
      ref.read(categoryProvider.notifier).reloadData();
      return true;
    } catch (e) {
      print("error adding category ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> deleteCategory(WidgetRef ref, Category c) async {
    print("deleting the category ${c.title}");
    try {
      Box<Category>? b = await openBox();
      if (b == null) {
        //to implement an error handling
        print("error in deleting a category");
        return false;
      }
      await b.delete(c.id);
      ref.read(categoryProvider.notifier).reloadData();
      return true;
    } catch (e) {
      print("error in deleting a category");
      return false;
    }
  }

  @override
  Future<bool> editCategory(WidgetRef ref, Category newC, Category oldC) async {
    try {
      Box<Category>? b = await openBox();
      if (b == null) {
        //to implement an error handling
        print("error in deleting a category");
        return false;
      }
      b.put(oldC.id, newC);
      ref.read(categoryProvider.notifier).reloadData();
      return true;
    } catch (e) {
      print("error in editing a category");
      return false;
    }
  }

  @override
  Future<void> getAllCategories(WidgetRef ref) async {
    Box<Category>? b = await openBox();
    if (b == null) {
      print("error opening category box ");
      return;
    }
    //adding elements to the provider
    for (Category v in b.values) {
      ref.read(categoryProvider.notifier).reloadData();
    }
  }

  @override
  Future<Box<Category>?> openBox() async {
    Box<Category> b = await Hive.openBox<Category>('Categories');
    return b;
  }

  @override
  Future<void> editCategoryValue(
      WidgetRef ref, Category category, double amount) async {
    //open the box
    Box<Category>? b = await openBox();
    if (b == null) {
      print("error opening category box");
      //to do : add error handling
      return;
    }
    //edit the value
    Category? cat = b.get(category.id);
    if (cat == null) {
      print("error getting the category with the id ${category.id}");
      return;
    }
    cat.amount = cat.amount + amount;
    //check if it's null delete

    if (cat.amount == 0) {
      deleteCategory(ref, cat);
      ref.read(categoryProvider.notifier).reloadData();
      return;
    }
    b.put(cat.id, cat);
    ref.read(categoryProvider.notifier).reloadData();

    //edit the provider
  }

  @override
  Future<bool> isExist(Category c) async {
    Box<Category>? b = await openBox();
    if (b == null) {
      print("error opening category box");
      return false;
    }
    return b.get(c.id) != null;
  }

  Future<List<Category>> getCategories() async {
    Box<Category>? b = await openBox();
    if (b == null) {
      print("can't opne category box");
      return [];
    }
    return b.values.toList();
  }

  @override
  Future<void> CategoryChangemnt(
      Category? oldC, Category? newC, WidgetRef ref) async {
    if (oldC != null && newC != null) {
      if (oldC == newC) {
        //same category
        editCategoryValue(ref, newC, newC.amount);
      } else {
        //deferent categories
        editCategoryValue(ref, oldC, -oldC.amount);
        editCategoryValue(ref, newC, newC.amount);
      }
      return;
    }

    if (oldC != null) {
      //category ==> no category
      editCategoryValue(ref, oldC, -oldC.amount);
      return;
    }
    if (newC != null) {
      //nocategory ==> category
      editCategoryValue(ref, newC, newC.amount);
      return;
    }
  }
}
