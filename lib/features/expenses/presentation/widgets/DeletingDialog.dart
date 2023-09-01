import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/expenses/presentation/widgets/AddExapnse.dart';
import 'package:wisely/features/incomes/data/hive/IncomeDb.dart';
import 'package:wisely/features/incomes/domain/entities/income.dart';
import 'package:wisely/features/incomes/presentation/widgets/AddIncome.dart';

import '../../data/hive/ExpansesDb.dart';
import '../../domain/entites/Expanses.dart';

Widget deletingDialog(WidgetRef ref, dynamic obj, BuildContext context) {
  ExpansesDb expansesDb = ExpansesDbImpl();
  IncomeDb incomeDb = IncomeDbImpl();
  return AlertDialog(
    content: Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        if (obj is Expanses) {
                          return Dialog(
                            child: AddExpanse(
                              e: obj,
                            ),
                          );
                        }
                        if (obj is Income) {
                          return Dialog(
                            child: addIncome(
                              i: obj,
                            ),
                          );
                        }
                        return Placeholder();
                      });
                },
                child: Text("edit"))),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  if (obj is Expanses) expansesDb.deleteExpanseDb(ref, obj);
                  if (obj is Income) incomeDb.deleteIncomeDb(ref, obj);
                  Navigator.pop(context);
                },
                child: Text("delete"))),
      ]),
    ),
  );
}
