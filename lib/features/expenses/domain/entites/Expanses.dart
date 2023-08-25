import 'package:wisely/features/categorise/domain/entitties/category.dart';
import 'package:hive/hive.dart';

part 'Expanses.g.dart';

@HiveType(typeId: 0)
class Expanses {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final Category? category;
  Expanses({required this.title, required this.amount, this.category});
}
