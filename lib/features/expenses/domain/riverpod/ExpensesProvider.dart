import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/expenses/data/hive/ExpansesDb.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

final expensesProvider2 =
    StateNotifierProvider<ExpansesNotifier, List<Expanses>>((ref) {
  return ExpansesNotifier();
});

class ExpansesNotifier extends StateNotifier<List<Expanses>> {
  ExpansesDb categoryDb = ExpansesDbImpl();
  ExpansesNotifier() : super([]);

  void reloadData() async {
    state = await categoryDb.getExpenses();
  }
/*
  void add(Expanses e) {
    state = [...state, e];
  }

  void edit(Expanses newE) {
    state = [
      for (final expense in state)
        if (expense == newE) newE else expense,
    ];
  }

  void delete(String id) {
    state = [
      for (final expense in state)
        if (expense.id != id) expense,
    ];
  }*/
}
