import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/core/Dialogs/LongPressDialog.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';
import 'package:wisely/features/expenses/domain/riverpod/ExpensesProvider.dart';
import 'package:wisely/features/expenses/presentation/widgets/dividers.dart';

import 'ExpenseTile.dart';

class ExpansesList extends ConsumerWidget {
  const ExpansesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("the length of the box is ${Hive.box<Expanses>("Expanses").length}");
    int date = 0;
    final expenses = ref.watch(expensesProvider2);
    print("i ama");
    print(expenses.length);
    expenses.sort(((a, b) {
      return b.date.compareTo(a.date);
    }));
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          print(
              "${expenses[index].title} ==> ${expenses[index].id} HASH CODE : ${expenses[index].hashCode}");
          if (DateTime.now().difference(expenses[index].date).inDays < 1) {
            if (date != 1) {
              date = 1;
              return Column(
                children: [
                  dividers("today"),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: LongPressDialog(
                                  ref, expenses[index], context)));
                    },
                    child: expenseTile(
                        context, expenses[index].title, expenses[index].amount),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            }
          } else if (DateTime.now().difference(expenses[index].date).inDays <
              2) {
            if (date != 2) {
              date = 2;
              return Column(
                children: [
                  dividers("yestrday"),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: LongPressDialog(
                                  ref, expenses[index], context)));
                    },
                    child: expenseTile(
                        context, expenses[index].title, expenses[index].amount),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            }
          } else {
            if (date != 3) {
              date = 3;
              return Column(
                children: [
                  dividers("before yestrday"),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: LongPressDialog(
                                  ref, expenses[index], context)));
                    },
                    child: expenseTile(
                        context, expenses[index].title, expenses[index].amount),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            }
          }
          return Column(
            children: [
              GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                          child:
                              LongPressDialog(ref, expenses[index], context)));
                },
                child: expenseTile(
                    context, expenses[index].title, expenses[index].amount),
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        });
  }
}
