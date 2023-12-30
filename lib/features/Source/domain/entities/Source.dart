import 'package:uuid/uuid.dart';

class Source {
  Uuid uuid = const Uuid();

  late String id;
  final String title;
  final int amount;
  final int color;

  Source({required this.title, required this.amount, required this.color}) {
    id = uuid.v1();
  }

  Source.withId({
    required this.id,
    required this.title,
    required this.amount,
    required this.color,
  });

  // Factory constructor to create Source from a map
  factory Source.fromMap(Map<String, dynamic> map) {
    return Source.withId(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'color': color,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Source && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
