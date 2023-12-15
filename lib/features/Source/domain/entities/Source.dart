import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'Source.g.dart';

@HiveType(typeId: 2)
class Source {
  Uuid uuid = Uuid();
  @HiveField(0)
  late String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final int color;
  Source({required this.title, required this.amount, required this.color}) {
    id = uuid.v1();
  }
}
