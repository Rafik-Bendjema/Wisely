import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisely/core/database/DataBase.dart';
import 'package:wisely/features/expenses/domain/riverpod/ExpensesProvider.dart';
import 'package:wisely/features/stats/data/mysql/statDb.dart';

import '../../../../core/resources/colors.dart';

class GoalBar extends ConsumerStatefulWidget {
  const GoalBar({Key? key}) : super(key: key);

  @override
  _GoalBarState createState() => _GoalBarState();
}

class _GoalBarState extends ConsumerState<GoalBar> {
  double thegoal = 3000;

  Future<void> getGoal() async {
    List<Map<String, dynamic>> m = await DatabaseHelper.database!.query("goal");

    thegoal = m[0]['goal'] as double;
    print("this is the goal $thegoal");
    setState(() {});
  }

  @override
  void initState() {
    getGoal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        double capacity;
        double expensessum = ref.watch(expensesSum);
        if (thegoal == 0) {
          capacity = 0;
        } else {
          capacity = expensessum * 300 / thegoal;
        }

        print("this is the expenses sum $expensessum");

        return Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    TextEditingController goalCntrl = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: SizedBox(
                          height: 100,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: goalCntrl,
                            onSubmitted: (val) {
                              StatDB statDB = StatDB_impl();
                              statDB.editGoal(double.parse(val));
                              getGoal();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text("edit"),
                ),
                Text(
                  "${thegoal.toInt().toString()}.00 ",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: secondary_color,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  width: 50,
                  height: 300,
                ),
                Positioned(
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                      color: (300 - capacity < 50) ? Colors.red : primary_color,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    width: 50,
                    height: capacity,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        expensessum.toInt().toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
