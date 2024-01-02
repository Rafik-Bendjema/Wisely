import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/expenses/data/sql/ExpansesDb.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

final expensesProvider2 =
    StateNotifierProvider<ExpansesNotifier, List<Expanses>>((ref) {
  return ExpansesNotifier();
});

class ExpansesNotifier extends StateNotifier<List<Expanses>> {
  ExpansesDb categoryDb = ExpansesDb_impl();
  ExpansesNotifier() : super([]);

  void reloadData() async {
    state = await categoryDb.getExpenses();
    print("this is the state ${state.length}");
  }
}

final expensesSum = StateNotifierProvider<expensesSumNotifier, double>((ref) {
  return expensesSumNotifier();
});

class expensesSumNotifier extends StateNotifier<double> {
  ExpansesDb expansesDb = ExpansesDb_impl();
  expensesSumNotifier() : super(0);
  void reloadData() async {
    state = await expansesDb.getExpensesSum();
  }
}
