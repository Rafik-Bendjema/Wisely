import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';
import 'package:wisely/features/Source/presentation/widgets/AddSource.dart';
import 'package:wisely/features/categorise/data/sqlite/CategoryDb.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'package:wisely/features/expenses/data/sql/ExpansesDb.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';
import 'package:wisely/features/expenses/presentation/widgets/AddExapnse.dart';
import 'package:wisely/features/income/data/sqlite/IncomeDb.dart';
import 'package:wisely/features/income/domain/entities/Income.dart';
import 'package:wisely/features/income/presentation/widgets/AddIncome.dart';

Widget LongPressDialog(WidgetRef ref, Object obj, BuildContext context) {
  ExpansesDb expansesDb = ExpansesDb_impl();
  CategoryDb categoryDb = CategoryDb_impl();
  SourceDb sourceDb = SourceDbImpl();
  IncomesDb incomesDb = IncomesDbImpl();
  return Material(
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
                onPressed: () {
                  if (obj is Expanses) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: AddExpanse(
                                e: obj,
                              ),
                            ));
                  }
                  if (obj is Income) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: AddIncome(
                                destination: obj,
                              ),
                            ));
                  }
                  if (obj is Source) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: AddSource(
                                destination: obj,
                              ),
                            ));
                  }
                },
                child: const Text("edit")),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
                onPressed: () async {
                  if (obj is Expanses) {
                    expansesDb.deleteExpanseDb(ref, obj);
                  }
                  if (obj is Category) {
                    categoryDb.deleteCategory(ref, obj);
                  }
                  if (obj is Income) {
                    incomesDb.deleteIncomeDb(ref, obj);
                  }
                  if (obj is Source) {
                    if (obj.id == "0") {
                      showDialog(
                          context: context,
                          builder: (context) => const Dialog(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      "you can't delete the main source",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ));
                    } else {
                      sourceDb.deleteSourceDb(ref, obj);
                    }
                  }
                },
                child: const Text("delete")),
          )
        ],
      ),
    ),
  );
}
