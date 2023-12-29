import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wisely/core/Dialogs/LongPressDialog.dart';
import 'package:wisely/core/database/DataBase.dart';
import 'package:wisely/core/resources/colors.dart';
import 'package:wisely/features/categorise/data/sqlite/CategoryDb.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'package:wisely/features/categorise/domain/riverpod/CategoryProvider.dart';
import 'package:wisely/features/expenses/data/sql/ExpansesDb.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CategoryDb categoryDb = CategoryDb_impl();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Consumer(
          builder: (context, ref, widget) {
            List<Category> categories = ref.watch(categoryProvider);
            return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  Category currentCat = categories[index];

                  return Column(
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          print("the selected item is ${currentCat.id}");
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                  child: LongPressDialog(
                                      ref, currentCat, context)));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 70,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              color: primary_color,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      currentCat.title,
                                      style: const TextStyle(
                                        color: Color(0xFFD3F9B5),
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          currentCat.amount.toInt().toString(),
                                      style: TextStyle(
                                          fontSize: 35, color: tertiary_color)),
                                  TextSpan(
                                      text: ".00",
                                      style: TextStyle(
                                          fontSize: 25, color: tertiary_color)),
                                  TextSpan(
                                      text: " dz",
                                      style: TextStyle(
                                          fontSize: 20, color: text_color))
                                ]),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Icon(
                                currentCat.icon != null
                                    ? IconData(currentCat.icon!,
                                        fontFamily: "MaterialIcons")
                                    : null,
                                color: Colors.white,
                                size: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  );
                });
          },
        ));
  }
}
