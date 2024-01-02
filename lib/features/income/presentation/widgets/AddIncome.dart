import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/domain/riverpod/SourceProvider.dart';
import 'package:wisely/features/income/data/sqlite/IncomeDb.dart';
import 'package:wisely/features/income/domain/entities/Income.dart';

import '../../../Source/domain/entities/Source.dart';

class AddIncome extends StatefulWidget {
  Income? destination;
  AddIncome({super.key, this.destination});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  @override
  void initState() {
    _destinitation = widget.destination;
    if (_destinitation != null) {
      title_controller = TextEditingController(text: _destinitation!.title);
      amount_controller =
          TextEditingController(text: _destinitation!.amount.toString());
      date_controller =
          TextEditingController(text: _destinitation!.date.toString());
      finalSource = _destinitation!.source;
    }
    super.initState();
  }

  SourceDb sourceDb = SourceDbImpl();
  IncomesDb incomesDb = IncomesDbImpl();
  final _formKey = GlobalKey<FormState>();

  TextEditingController amount_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  TextEditingController title_controller = TextEditingController();

  late String title;
  late int amount;
  late String date;

  late Source finalSource;
  String? source;
  Income? _destinitation;
  DateTime dateTime = DateTime.now();

  void verification(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //treat the source field

      print("this is the source inserted ${finalSource.title}");
      Income income = Income(
          title: title, amount: amount, date: dateTime, source: finalSource);
      if (_destinitation != null) {
        income.id = _destinitation!.id;
        await incomesDb.editIncome(ref, income);
      } else {
        await incomesDb.addIncomeDb(ref, income);
      }
    }
  }

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
                controller: title_controller,
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
                      controller: amount_controller,
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
                      decoration: const InputDecoration(hintText: "amount"),
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
                  controller: date_controller,
                )),
                TextButton(
                    onPressed: () async {
                      var choosedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)));
                      if (choosedDate != null && choosedDate != dateTime) {
                        setState(() {
                          dateTime = choosedDate;
                          date_controller = TextEditingController(
                              text: DateFormat("dd-MM-yyyy").format(dateTime));
                        });
                      }
                    },
                    child: const Text("Pick a date")),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Consumer(builder: (contenxt, ref, child) {
              List<Source> suggestions = ref.watch(sourceProvider);
              return DropdownButtonFormField(
                  items: suggestions.map((Source s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(s.title),
                    );
                  }).toList(),
                  onChanged: (cal) {
                    if (cal != null) {
                      finalSource = cal;
                    }
                  });
            }),
          ),
          SizedBox(
              height: 100,
              child: Center(
                  child: Consumer(
                builder: (context, ref, widget) => TextButton(
                    onPressed: () {
                      verification(ref);
                      Navigator.pop(context);
                    },
                    child: (_destinitation == null)
                        ? const Text("Add")
                        : const Text("edit")),
              )))
        ]),
      ),
    );
  }
}
