import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

import '../../../../core/database/DataBase.dart';
import '../../domain/entities/Income.dart';

abstract class IncomesDb {
  Future<bool> addIncomeDb(WidgetRef ref, Income income);
  Future<bool> deleteIncomeDb(WidgetRef ref, Income income);
  Future<bool> editIncome(WidgetRef ref, Income newIncome, Income oldIncome);
  Future<List<Income>> getIncomes();
}

class IncomesDbImpl implements IncomesDb {
  @override
  Future<bool> addIncomeDb(WidgetRef ref, Income income) async {
    try {
      await DatabaseHelper.database!.insert('incomes', income.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      // Reload data for any provider that needs to react to income changes
      // ref.read(incomesProvider.notifier).reloadData();
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
          .delete('incomes', where: "id = ?", whereArgs: [income.id]);
      // Reload data for any provider that needs to react to income changes
      // ref.read(incomesProvider.notifier).reloadData();
      return true;
    } on Exception catch (e) {
      print("Error in deleting income. Error: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> editIncome(WidgetRef ref, Income newIncome, Income oldIncome) {
    // TODO: Implement editIncome
    throw UnimplementedError();
  }

  @override
  Future<List<Income>> getIncomes() async {
    List<Income> incomesList = [];
    await DatabaseHelper.opendatabase();
    List<Map<String, dynamic>> incomesMap =
        await DatabaseHelper.database!.query('incomes');

    print("This is the incomes $incomesMap");
    // Generate a list from the map
    incomesMap.forEach((element) async {
      Income curr = Income.withId(
        id: element['id'] as String,
        title: element['title'] as String,
        amount: element['amount'] as int,
        date: DateTime.parse(element['date'] as String),
      );
      incomesList.add(curr);
    });
    return incomesList;
  }
}
