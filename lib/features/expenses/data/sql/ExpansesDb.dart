import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';
import 'package:wisely/features/categorise/data/sqlite/CategoryDb.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'package:wisely/features/categorise/domain/riverpod/CategoryProvider.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';
import 'package:wisely/features/expenses/domain/riverpod/ExpensesProvider.dart';

import '../../../../core/database/DataBase.dart';

abstract class ExpansesDb {
  Future<bool> addExpanseDb(WidgetRef ref, Expanses e);
  Future<bool> deleteExpanseDb(WidgetRef ref, Expanses e);
  Future<List<Expanses>> getExpenses();
  Future<bool> editExpenses(WidgetRef ref, Expanses newE);
  Future<double> getExpensesSum();
}

class ExpansesDb_impl implements ExpansesDb {
  CategoryDb categoryDb = CategoryDb_impl();
  SourceDb sourceDb = SourceDbImpl();
  @override
  Future<bool> addExpanseDb(WidgetRef ref, Expanses e) async {
    try {
      await DatabaseHelper.database!.insert('expenses', e.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      ref.read(expensesProvider2.notifier).reloadData();
      ref.read(categoryProvider.notifier).reloadData();
      ref.read(expensesSum.notifier).reloadData();
      ref.read(sourceProvider.notifier).reloadData();
      return true;
    } catch (e) {
      print("error in adding an expanse \n error : ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> deleteExpanseDb(WidgetRef ref, Expanses e) async {
    try {
      await DatabaseHelper.database!
          .delete('expenses', where: "id = ?", whereArgs: [e.id]);
      ref.read(expensesProvider2.notifier).reloadData();
      ref.read(categoryProvider.notifier).reloadData();
      ref.read(expensesSum.notifier).reloadData();
      ref.read(sourceProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      print("error in deleting expanses");
      return false;
    }
  }

  @override
  Future<bool> editExpenses(WidgetRef ref, Expanses newE) async {
    try {
      await DatabaseHelper.database!.update('expenses', newE.toMap(),
          where: "id = ?", whereArgs: [newE.id]);
      ref.read(expensesProvider2.notifier).reloadData();
      ref.read(categoryProvider.notifier).reloadData();
      ref.read(expensesSum.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      // TODO
      return false;
    }
  }

  @override
  Future<double> getExpensesSum() async {
    double sum = 0;
    await DatabaseHelper.opendatabase();
    List<Map<String, dynamic>> expansesMap =
        await DatabaseHelper.database!.query('expenses');

    //generate a list from the map
    expansesMap.forEach((element) async {
      sum += (element['amount'] as int);
    });
    return sum;
  }

  @override
  Future<List<Expanses>> getExpenses() async {
    List<Expanses> expansesList = [];
    await DatabaseHelper.opendatabase();
    List<Map<String, dynamic>> expansesMap =
        await DatabaseHelper.database!.query('expenses');
    print("this is the expanses $expansesMap");
    //generate a list from the map
    for (Map<String, dynamic> element in expansesMap) {
      Category? cat = await categoryDb.getCategory(element['category']);
      Source? source = await sourceDb.getSource(element['source']);
      Expanses curr = Expanses.withId(
          source: source!,
          id: element['id'] as String,
          title: element['title'] as String,
          date: DateTime.parse(element['date_ex'] as String),
          amount: element['amount'] as int,
          category: cat);

      expansesList.add(curr);
    }
    print("returning ${expansesList.length}");
    return expansesList;
  }
}
