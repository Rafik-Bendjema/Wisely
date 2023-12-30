import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/expenses/presentation/widgets/dividers.dart';
import 'package:wisely/features/income/domain/riverpod/IncomProvider.dart';

import '../../../../core/Dialogs/LongPressDialog.dart';
import '../../../expenses/presentation/widgets/ExpenseTile.dart';

class IncomeList extends ConsumerWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int date = 0;
    final incomes = ref.watch(incomeProvider);
    print("i ama");
    print(incomes.length);
    incomes.sort(((a, b) {
      return b.date.compareTo(a.date);
    }));
    return ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (context, index) {
          print(
              "${incomes[index].title} ==> ${incomes[index].id} HASH CODE : ${incomes[index].hashCode}");
          if (DateTime.now().difference(incomes[index].date).inDays < 1) {
            if (date != 1) {
              date = 1;
              return Column(
                children: [
                  dividers("today"),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: LongPressDialog(
                                  ref, incomes[index], context)));
                    },
                    child: expenseTile(
                        context, incomes[index].title, incomes[index].amount),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            }
          } else if (DateTime.now().difference(incomes[index].date).inDays <
              2) {
            if (date != 2) {
              date = 2;
              return Column(
                children: [
                  dividers("yestrday"),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: LongPressDialog(
                                  ref, incomes[index], context)));
                    },
                    child: expenseTile(
                        context, incomes[index].title, incomes[index].amount),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: LongPressDialog(
                                  ref, incomes[index], context)));
                    },
                    child: expenseTile(
                        context, incomes[index].title, incomes[index].amount),
                  ),
                  const SizedBox(
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
                              LongPressDialog(ref, incomes[index], context)));
                },
                child: expenseTile(
                    context, incomes[index].title, incomes[index].amount),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }
}
