import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    } catch (e) {
      print("error while adding to the box ${e.toString()}");
      return false;
    }
    return true;
  }

  @override
  Future<bool> editExpenses(WidgetRef ref, Expanses newE, Expanses oldE) async {
    //delete the previous object
    bool state = await deleteExpanseDb(ref, oldE);
    //add a new one
    if (state) {
      addExpanseDb(ref, newE);
    } else {
      print("error in adding expanse");
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
