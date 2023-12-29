import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

import '../../domain/repository/ExpansesRepository.dart';
import '../sql/ExpansesDb.dart';

class ExpansesRepositoryImpl implements ExpansesRepository {
  final ExpansesDb expansesDb;

  ExpansesRepositoryImpl(this.expansesDb);
  @override
  Future<bool> addExpanse(Expanses e) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteExpanse(Expanses e) {
    // TODO: implement deleteExpanse
    throw UnimplementedError();
  }

  @override
  Future<bool> editExpense(Expanses e) {
    // TODO: implement editExpense
    throw UnimplementedError();
  }
}
