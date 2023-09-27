import 'package:wisely/features/categorise/domain/entitties/categoryy.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'Expanses.g.dart';

@HiveType(typeId: 0)
class Expanses {
  Uuid uuid = Uuid();
  @HiveField(0)
  final String title;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final Category? category;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  late String id;
  Expanses(
      {required this.title,
      required this.amount,
      this.category,
      required this.date}) {
    id = uuid.v1();
  }
}
