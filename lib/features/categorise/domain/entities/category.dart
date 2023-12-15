import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category {
  Uuid uuid = Uuid();
  @HiveField(0)
  late String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double amount = 0;
  @HiveField(3)
  int? icon;
  Category({this.icon, required this.title}) {
    id = uuid.v1();
  }

  @override
  bool operator ==(other) {
    return (other is Category) && (other.id == id);
  }
}
