import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/features/expenses/domain/entites/Expanses.dart';

import '../../data/hive/ExpansesDb.dart';
import 'package:intl/intl.dart';

class AddExpanse extends StatefulWidget {
  final Expanses? e;
  AddExpanse({super.key, this.e});

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  late String title;
  late int amount;
  late DateTime dateTime = DateTime.now();
  late TextEditingController date;
  late Expanses? _destination;

  //controllers
  TextEditingController title_cntrl = TextEditingController();
  TextEditingController amount_cntrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _destination = widget.e;
    if (_destination != null) {
      title_cntrl = TextEditingController(text: _destination!.title);
      amount_cntrl =
          TextEditingController(text: _destination!.amount.toString());
      date = TextEditingController(
          text: DateFormat("dd-MM-yyyy").format(_destination!.date));
    } else {
      date = TextEditingController(
          text: DateFormat("dd-MM-yyyy").format(dateTime));
    }
  }

  void verification(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      final expansesDb = ExpansesDbImpl();

      _formKey.currentState!.save();
      Expanses e = Expanses(title: title, amount: amount, date: dateTime);
      bool status;
      if (_destination == null) {
        status = await expansesDb.addExpanseDb(ref, e).then((value) {
          Navigator.pop(context);
          return true;
        });
      } else {
        status =
            await expansesDb.editExpenses(ref, e, _destination!).then((value) {
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
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Form(
        key: _formKey,
        child: Column(children: [
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
                decoration: InputDecoration(hintText: "title"),
              )),
          SizedBox(
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
                      decoration: InputDecoration(hintText: "price"),
                    )),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter, child: Text("Dzd")))
              ],
            ),
          ),
          Row(
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
                  child: Text("Pick a date"))
            ],
          ),
          Expanded(
              child: Center(
                  child: Consumer(
            builder: (context, ref, widget) => TextButton(
                onPressed: () {
                  verification(ref);
                },
                child: (_destination == null) ? Text("Add") : Text("edit")),
          )))
        ]),
      ),
    );
  }
}
