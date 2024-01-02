import 'package:wisely/core/database/DataBase.dart';

abstract class StatDB {
  Future<void> editGoal(double goal);
}

class StatDB_impl implements StatDB {
  @override
  Future<void> editGoal(double goal) async {
    await DatabaseHelper.database!.update('goal', {'id': 0, 'goal': goal},
        where: "id = ?", whereArgs: [0]);
  }
}
