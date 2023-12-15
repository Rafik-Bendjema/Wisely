import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/categorise/data/hive/CategoryDb.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';
import 'package:wisely/features/expenses/domain/riverpod/ExpensesProvider.dart';

abstract class ExpansesDb {
  Future<Box<Expanses>?> openBox();
  Future<bool> addExpanseDb(WidgetRef ref, Expanses e);
  Future<bool> deleteExpanseDb(WidgetRef ref, Expanses e);
  Future<void> getAllExpenses(WidgetRef ref);
  Future<List<Expanses>> getExpenses();
  Future<bool> editExpenses(WidgetRef ref, Expanses newE, Expanses oldE);
}

class ExpansesDbImpl implements ExpansesDb {
  final CategoryDb categoryDb = CategoryDbImpl();
  @override
  Future<Box<Expanses>?> openBox() async {
    try {
      var box = await Hive.openBox<Expanses>("Expanses");
      return box;
    } catch (e) {
      print("error : ${e.toString()}");
    }
    return null;
  }

  @override
  Future<void> getAllExpenses(WidgetRef ref) async {
    var b = await Hive.openBox<Expanses>("Expanses");
    print("i am here and this is the elements ${b.values.length.toString()}");
  }

  @override
  Future<bool> addExpanseDb(WidgetRef ref, Expanses e) async {
    Box<Expanses> b = await Hive.openBox<Expanses>("Expanses");
    try {
      await b.put(e.id, e);
      ref.read(expensesProvider2.notifier).reloadData();
      await categoryDb.editCategoryValue(ref, e.category!, e.amount.toDouble());
    } catch (e) {
      print("error while adding to the box ${e.toString()}");
      return false;
    }
    return true;
  }

  @override
  Future<bool> editExpenses(WidgetRef ref, Expanses newE, Expanses oldE) async {
    Box<Expanses> b = await Hive.openBox<Expanses>("Expanses");
    // we have 4 cases about categorise
    //1 - no category -> to category DONE
    //2 - category -> no category  Done
    //3 - change the category DONE
    //4 - edit the same category DONE
    await categoryDb.CategoryChangemnt(oldE.category, newE.category, ref);

    try {
      await b.delete(oldE.id);
      await b.put(newE.id, newE);
      ref.read(expensesProvider2.notifier).reloadData();
    } on Exception catch (e) {
      print("error in editing an exapnse error : $e");
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteExpanseDb(WidgetRef ref, Expanses e) async {
    print("deleting the id ${e.id}");
    try {
      Box<Expanses>? b = await openBox();
      if (b == null) {
        print("erro in deleting ${e.toString()}");
        return false;
      }
      if (e.category != null) {
        await categoryDb.editCategoryValue(
            ref, e.category!, -e.amount.toDouble());
      }
      await b.delete(e.id);
      ref.read(expensesProvider2.notifier).reloadData();
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<List<Expanses>> getExpenses() async {
    Box<Expanses>? b = await openBox();
    if (b == null) {
      print("error opening the expenses box ");
      return [];
    }
    return b.values.toList();
  }
}
