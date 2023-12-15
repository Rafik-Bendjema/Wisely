import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'Income.g.dart';

@HiveType(typeId: 3)
class Income {
  Uuid uuid = Uuid();
  @HiveField(0)
  late String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  Income({required this.title, required this.amount, required this.date}) {
    id = uuid.v1();
  }
}
