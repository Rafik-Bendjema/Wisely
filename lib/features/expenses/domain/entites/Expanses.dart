import 'package:uuid/uuid.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';

class Expanses {
  Uuid uuid = const Uuid();
  final String title;
  final int amount;
  final Category? category;
  final DateTime date;
  late String id;
  final Source source;

  Expanses(
      {required this.title,
      required this.source,
      required this.amount,
      this.category,
      required this.date}) {
    id = uuid.v1();
  }

  Expanses.withId(
      {required this.id,
      required this.title,
      required this.date,
      this.category,
      required this.amount,
      required this.source});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date_ex': date.toString(),
      'category': category?.id,
      'Source': source.id
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(other) {
    return (other is Expanses) && (other.id == id);
  }
}
