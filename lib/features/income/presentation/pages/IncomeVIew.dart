import 'package:flutter/material.dart';
import 'package:wisely/features/income/presentation/widgets/AddIncome.dart';
import 'package:wisely/features/income/presentation/widgets/IncomeList.dart';

import '../../../../core/resources/colors.dart';

class IncomeView extends StatefulWidget {
  const IncomeView({super.key});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: AddIncome(),
                  ));
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: background_color),
          child: const SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Incomes",
                    style: TextStyle(
                        fontSize: 36, color: Color.fromARGB(189, 0, 0, 0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: IncomeList())
              ],
            ),
          )),
    );
  }
}
