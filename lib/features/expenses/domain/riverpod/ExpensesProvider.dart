import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/expenses/data/hive/ExpansesDb.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

final expensesProvider = FutureProvider<List<Expanses>>((ref) async {
  final box =
      await Hive.box<Expanses>('Expanses'); // Use your class name and box name.

  return box.values.toList();
});

final expensesProvider2 =
    StateNotifierProvider<ExpansesNotifier, List<Expanses>>((ref) {
  return ExpansesNotifier();
});

class ExpansesNotifier extends StateNotifier<List<Expanses>> {
  ExpansesNotifier() : super([]);

  void add(Expanses e) {
    state = [...state, e];
  }

  void delete(String id) {
    state = [
      for (final expense in state)
        if (expense.id != id) expense,
    ];
  }
}
