import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/hive/ExpansesDb.dart';
import '../../domain/entites/Expanses.dart';

Widget deletingDialog(WidgetRef ref, Expanses e, BuildContext context) {
  ExpansesDb expansesDb = ExpansesDbImpl();
  return AlertDialog(
    content: Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(onPressed: () {}, child: Text("edit"))),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  expansesDb.deleteExpanseDb(ref, e);
                  Navigator.pop(context);
                },
                child: Text("delete"))),
      ]),
    ),
  );
}
