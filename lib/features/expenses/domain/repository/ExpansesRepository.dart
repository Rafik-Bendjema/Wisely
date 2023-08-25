import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

abstract class ExansesRepository {
  //add expanse
  Future<bool> addExpanse(Expanses e);
  //delete expanse
  Future<bool> deleteExpanse(Expanses e);
  //edit expanse
  Future<bool> editExpense(Expanses e);
}
