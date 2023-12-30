import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/income/data/sqlite/IncomeDb.dart';

import '../entities/Income.dart';

final incomeProvider =
    StateNotifierProvider<IncomeNotifier, List<Income>>((ref) {
  return IncomeNotifier();
});

class IncomeNotifier extends StateNotifier<List<Income>> {
  IncomesDb incomesDb = IncomesDbImpl();
  IncomeNotifier() : super([]);

  void reloadData() async {
    state = await incomesDb.getIncomes();
  }
/*
  void add(Incomee) {
    state = [...state, e];
  }

  void edit(IncomenewE) {
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
