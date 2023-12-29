import 'package:uuid/uuid.dart';

class Income {
  Uuid uuid = const Uuid();

  late String id;
  final String title;
  final int amount;
  final DateTime date;

  Income({
    required this.title,
    required this.amount,
    required this.date,
  }) {
    id = uuid.v1();
  }

  Income.withId({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toString(),
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Income && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
