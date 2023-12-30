import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
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
  SourceDb sourceDb = SourceDbImpl();
  IncomesDb incomesDb = IncomesDbImpl();
  final _formKey = GlobalKey<FormState>();

  TextEditingController amount_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  TextEditingController title_controller = TextEditingController();

  late String title;
  late int amount;
  late String date;
  String? source;
  Income? _destinitation;
  DateTime dateTime = DateTime.now();

  void verification(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //treat the source field
      Source? finalSource = await sourceDb.getSource(source, ref);
      print("this is the source inserted ${finalSource?.title}");
      Income income = Income(
          title: title, amount: amount, date: dateTime, source: finalSource);
      await incomesDb.addIncomeDb(ref, income);
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
                          firstDate: DateTime.parse("2012-01-01"),
                          lastDate: DateTime.now());
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
              child: TextFormField(
                onSaved: (val) {
                  if (val != null && val.isNotEmpty) {
                    source = val;
                  }
                },
                decoration: const InputDecoration(hintText: "source"),
              )),
          SizedBox(
              height: 100,
              child: Center(
                  child: Consumer(
                builder: (context, ref, widget) => TextButton(
                    onPressed: () {
                      verification(ref);
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
