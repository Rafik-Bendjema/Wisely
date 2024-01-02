import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';
import 'package:wisely/features/income/domain/riverpod/IncomProvider.dart';

import '../../../../core/database/DataBase.dart';
import '../../domain/entities/Income.dart';

abstract class IncomesDb {
  Future<bool> addIncomeDb(WidgetRef ref, Income income);
  Future<bool> deleteIncomeDb(WidgetRef ref, Income income);
  Future<bool> editIncome(WidgetRef ref, Income newIncome);
  Future<List<Income>> getIncomes();
}

class IncomesDbImpl implements IncomesDb {
  SourceDb sourceDb = SourceDbImpl();
  @override
  Future<bool> addIncomeDb(WidgetRef ref, Income income) async {
    try {
      await DatabaseHelper.database!.insert('income', income.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      // Reload data for any provider that needs to react to income changes
      ref.read(incomeProvider.notifier).reloadData();
      ref.read(sourceProvider.notifier).reloadData();
      return true;
    } catch (e) {
      print("Error in adding an income. Error: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> deleteIncomeDb(WidgetRef ref, Income income) async {
    try {
      await DatabaseHelper.database!
          .delete('income', where: "id = ?", whereArgs: [income.id]);
      // Reload data for any provider that needs to react to income changes
      ref.read(incomeProvider.notifier).reloadData();
      ref.read(sourceProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      print("Error in deleting income. Error: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> editIncome(WidgetRef ref, Income newIncome) async {
    try {
      await DatabaseHelper.database!.update('income', newIncome.toMap(),
          where: "id = ?", whereArgs: [newIncome.id]);
      ref.read(incomeProvider.notifier).reloadData();
      ref.read(sourceProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      // TODO
      return false;
    }
  }

  @override
  Future<List<Income>> getIncomes() async {
    List<Income> incomesList = [];
    await DatabaseHelper.opendatabase();
    List<Map<String, dynamic>> incomesMap =
        await DatabaseHelper.database!.query('income');

    print("This is the incomes $incomesMap");
    for (Map<String, dynamic> element in incomesMap) {
      Source? source = await sourceDb.getSource(element['source']);
      if (source != null) {
        Income curr = Income.withId(
            id: element['id'] as String,
            title: element['title'] as String,
            amount: element['amount'] as int,
            date: DateTime.parse(element['date_inc'] as String),
            source: source);
        incomesList.add(curr);
      }
    }
    // Generate a list from the map
    return incomesList;
  }
}
