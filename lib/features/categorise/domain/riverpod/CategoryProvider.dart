import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/categorise/data/sqlite/CategoryDb.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryDb categoryDb = CategoryDb_impl();
  CategoryNotifier() : super([]);

  void reloadData() async {
    state = await categoryDb.getCategories();
  }
}
