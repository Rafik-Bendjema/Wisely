import 'package:uuid/uuid.dart';

import '../../../Source/domain/entities/Source.dart';

class Income {
  Uuid uuid = const Uuid();

  late String id;
  final String title;
  final int amount;
  final DateTime date;
  final Source source;

  Income({
    required this.title,
    required this.amount,
    required this.date,
    required this.source,
  }) {
    id = uuid.v1();
  }

  Income.withId({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.source,
  });

  // Factory constructor to create Income from a ma

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date_inc': date.toString(),
      'source': source.id,
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
