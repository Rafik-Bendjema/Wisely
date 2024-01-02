import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';
import 'package:wisely/features/Source/data/hive/SourceDb.dart';
import 'package:wisely/features/Source/presentation/widgets/AddSource.dart';
import 'package:wisely/features/Source/presentation/widgets/SourcesList.dart';
import 'package:wisely/features/categorise/presentation/widgets/AddCategory.dart';
import 'package:wisely/features/categorise/presentation/widgets/CategoryList.dart';
import 'package:wisely/features/expenses/presentation/pages/ExpensesView.dart';
import 'package:wisely/features/expenses/presentation/widgets/Cart_view.dart';
import 'package:wisely/features/income/presentation/pages/IncomeVIew.dart';
import 'package:wisely/features/stats/presentation/widgets/GoalBar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SourceDb sourceDb = SourceDbImpl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Sources",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: AddSource(),
                            ),
                          );
                        },
                        child: const Text("ADD"),
                      )
                    ],
                  ),
                  const SourcesList(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent,
                                ),
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExpansesView(),
                                  ),
                                );
                              },
                              child: CartButton(
                                isexpense: true,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const IncomeView(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent,
                                ),
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent,
                                ),
                              ),
                              child: CartButton(
                                isexpense: false,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Expanded(
                        // Use Expanded with FlexFit.loose
                        child: Center(child: GoalBar()),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15 - 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(fontSize: 15, color: text_color),
                        ),
                        TextButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => const Dialog(
                                child: AddCategory(),
                              ),
                            );
                          },
                          child: Text(
                            "ADD +",
                            style:
                                TextStyle(color: primary_color, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Remove Expanded around CategoryList
                  const CategoryList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
