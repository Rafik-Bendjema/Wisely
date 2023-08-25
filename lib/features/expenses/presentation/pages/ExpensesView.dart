import 'package:flutter/material.dart';
import 'package:wisely/features/expenses/presentation/widgets/AddExapnse.dart';
import 'package:wisely/features/expenses/presentation/widgets/dividers.dart';

import '../../../../core/resources/colors.dart';
import '../widgets/ExpenseTile.dart';

class ExpansesView extends StatefulWidget {
  const ExpansesView({super.key});

  @override
  State<ExpansesView> createState() => _ExpansesViewState();
}

class _ExpansesViewState extends State<ExpansesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: AddExpanse(),
                  ));
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: background_color),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Expanses",
                    style: TextStyle(
                        fontSize: 36, color: Color.fromARGB(189, 0, 0, 0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                dividers("today"),
                SizedBox(
                  height: 20,
                ),
                expenseTile(context, "10 eggs", 200)
              ],
            ),
          )),
    );
  }
}
