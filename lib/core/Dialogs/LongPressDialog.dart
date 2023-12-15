import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/categorise/data/hive/CategoryDb.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'package:wisely/features/expenses/data/hive/ExpansesDb.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';
import 'package:wisely/features/expenses/presentation/widgets/AddExapnse.dart';

Widget LongPressDialog(WidgetRef ref, Object obj, BuildContext context) {
  ExpansesDb expansesDb = ExpansesDbImpl();
  CategoryDb categoryDb = CategoryDbImpl();
  return Material(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                },
                child: Text("edit")),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
                onPressed: () async {
                  if (obj is Expanses) {
                    expansesDb.deleteExpanseDb(ref, obj);
                  }
                  if (obj is Category) {
                    await categoryDb
                        .deleteCategory(ref, obj)
                        .then((value) => {Navigator.pop(context)});
                  }
                },
                child: Text("delete")),
          )
        ],
      ),
    ),
  );
}
