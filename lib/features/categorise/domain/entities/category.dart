import 'package:uuid/uuid.dart';

class Category {
  Uuid uuid = const Uuid();
  late String id;
  String title;
  int amount = 0;
  int? icon;
  Category({this.icon, required this.title}) {
    id = uuid.v1();
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category.withId(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      icon: map['icon'],
    );
  }

  Category.withId(
      {required this.id, required this.title, required this.amount, this.icon});
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'amount': amount, 'icon': icon};
  }
}
