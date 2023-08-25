import 'package:flutter/material.dart';

class AddExpanse extends StatefulWidget {
  const AddExpanse({super.key});

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
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
                      decoration: InputDecoration(hintText: "price"),
                    )),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter, child: Text("Dzd")))
              ],
            ),
          ),
          Expanded(
              child: Center(
                  child: TextButton(onPressed: () {}, child: Text("Add"))))
        ]),
      ),
    );
  }
}
