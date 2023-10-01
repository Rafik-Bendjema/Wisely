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

    for (var i = 0; i < b.length; i++) {
      print("hey");
      Expanses e = b.getAt(i) as Expanses;
      ref.read(expensesProvider2.notifier).add(e);
    }
  }

  @override
  Future<bool> addExpanseDb(WidgetRef ref, Expanses e) async {
    Box<Expanses> b = await Hive.openBox<Expanses>("Expanses");
    try {
      await b.put(e.id, e);
      ref.read(expensesProvider2.notifier).add(e);
      await categoryDb.editCategoryValue(ref, e.category!, e.amount);
    } catch (e) {
      print("error while adding to the box ${e.toString()}");
      return false;
    }
    return true;
  }

  @override
  Future<bool> editExpenses(WidgetRef ref, Expanses newE, Expanses oldE) async {
    Box<Expanses> b = await Hive.openBox<Expanses>("Expanses");
    // we have 3 cases about categorise
    //1 - no category -> to category DONE
    //2 - category -> no category  Done
    //3 - change the category DONE
    //4 - edit the same category DONE
    if (oldE.category == null) {
      if (newE.category != null) {
        await categoryDb.editCategoryValue(ref, newE.category!, newE.amount);
      }
    } else {
      if (newE.category != null) {
        if (newE.category == oldE.category) {
          await categoryDb.editCategoryValue(
              ref, newE.category!, newE.amount - oldE.amount);
        } else {
          await categoryDb.editCategoryValue(ref, oldE.category!, -oldE.amount);
          await categoryDb.editCategoryValue(ref, newE.category!, newE.amount);
        }
      } else {
        await categoryDb.editCategoryValue(ref, oldE.category!, -oldE.amount);
      }
    }

    try {
      b.put(oldE.id, newE);
      ref.read(expensesProvider2.notifier).edit(newE);
    } on Exception catch (e) {
      print("error in editing an exapnse error : $e");
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteExpanseDb(WidgetRef ref, Expanses e) async {
    try {
      await Hive.box<Expanses>("Expanses").delete(e.id);
      ref.read(expensesProvider2.notifier).delete(e.id);
    } catch (e) {
      print("erro in deleting ${e.toString()}");
      return false;
    }
    return true;
  }
}
