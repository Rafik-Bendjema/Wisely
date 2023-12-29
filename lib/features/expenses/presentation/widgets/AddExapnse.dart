import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/categorise/data/sqlite/CategoryDb.dart';
import 'package:wisely/features/categorise/domain/entities/category.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

import '../../../categorise/domain/riverpod/CategoryProvider.dart';
import '../../data/sql/ExpansesDb.dart';
import 'package:intl/intl.dart';

class AddExpanse extends StatefulWidget {
  final Expanses? e;
  const AddExpanse({super.key, this.e});

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  bool choiced = false;
  late String title;
  late int amount;
  Category? _category;
  late DateTime dateTime = DateTime.now();
  late TextEditingController date;
  Expanses? _destination;

  //controllers
  TextEditingController title_cntrl = TextEditingController();
  TextEditingController amount_cntrl = TextEditingController();
  TextEditingController category_cntrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _destination = widget.e;
    if (_destination != null) {
      title_cntrl = TextEditingController(text: _destination!.title);
      amount_cntrl =
          TextEditingController(text: _destination!.amount.toString());
      if (_destination!.category != null) {
        category_cntrl =
            TextEditingController(text: _destination!.category!.title);
      }

      date = TextEditingController(
          text: DateFormat("dd-MM-yyyy").format(_destination!.date));
    } else {
      date = TextEditingController(
          text: DateFormat("dd-MM-yyyy").format(dateTime));
    }
  }

  void verification(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      final ExpansesDb expansesDb = ExpansesDb_impl();
      final CategoryDb categoryDb = CategoryDb_impl();
      _formKey.currentState!.save();

      Expanses e = Expanses(
          title: title, amount: amount, date: dateTime, category: _category);
      /*    if (_category != null) {
        e.category!.amount = e.category!.amount + e.amount;
        //  categoryDb.addCategoryDb(ref, _category!);
      }*/
      bool status;
      if (_destination == null) {
        status = await expansesDb.addExpanseDb(ref, e).then((value) {
          Navigator.pop(context);
          return true;
        });
      } else {
        status = await expansesDb
            .editExpenses(ref, e,
                _destination!) //e.amount = 15 and e.category.amount = 200
            .then((value) async {
          // dest.amount = 20 and dest.category.amount = 205
          Navigator.pop(context);
          return true;
        });
      }

      if (!status) {
        print("error");
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                controller: title_cntrl,
                onSaved: (newValue) {
                  title = newValue!;
                },
                validator: (val) {
                  if (val == null) {
                    return "field can't be null";
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "title"),
              )),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: TextFormField(
                      controller: amount_cntrl,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        amount = int.parse(newValue!);
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "field can't be null";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "price"),
                    )),
                const Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter, child: Text("Dzd")))
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: TextField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  controller: date,
                )),
                TextButton(
                    onPressed: () async {
                      var choosedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.parse("2012-01-01"),
                          lastDate: DateTime.now());
                      if (choosedDate != null && choosedDate != dateTime) {
                        setState(() {
                          dateTime = choosedDate;
                          date = TextEditingController(
                              text: DateFormat("dd-MM-yyyy").format(dateTime));
                        });
                      }
                    },
                    child: const Text("Pick a date"))
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Consumer(
                builder: (context, ref, child) {
                  List<Category> categories = ref.read(categoryProvider);
                  List<String> suggestions = [
                    for (final cat in categories) cat.title
                  ];
                  print("this is the list of suggestions $suggestions");
                  return Autocomplete(
                    onSelected: (selected) {
                      print("this is the selected string $selected");
                    },
                    fieldViewBuilder:
                        (context, categoryCntrl, focusNode, onFieldSubmitted) =>
                            TextFormField(
                      onSaved: (newValue) {
                        if (newValue != null && newValue.isNotEmpty) {
                          for (var cat in categories) {
                            if (cat.title == newValue) {
                              //  cat.amount = cat.amount + amount;
                              _category = cat;

                              return;
                            }
                          }
                          CategoryDb categoryDb = CategoryDb_impl();
                          Category newCat = Category(title: newValue);
                          //   newCat.amount = amount.toDouble();
                          categoryDb.addCategoryDb(ref, newCat);
                          _category = newCat;
                        }
                      },
                      controller: category_cntrl,
                      focusNode: focusNode,
                      decoration: const InputDecoration(hintText: "category"),
                    ),
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      } else {
                        print("this is list of matchs");
                        List<String> matches = <String>[];
                        matches.addAll(suggestions);

                        matches.retainWhere((s) {
                          return s
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                        return matches;
                      }
                    },
                  );
                },
              )),
          SizedBox(
              height: 100,
              child: Center(
                  child: Consumer(
                builder: (context, ref, widget) => TextButton(
                    onPressed: () {
                      verification(ref);
                    },
                    child: (_destination == null)
                        ? const Text("Add")
                        : const Text("edit")),
              )))
        ]),
      ),
    );
  }
}
