import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wisely/core/resources/colors.dart';
import 'package:wisely/features/budget_categ/presentation/widgets/Bcateg_Card.dart';
import 'package:wisely/features/categorise/presentation/widgets/CategoryCard.dart';
import 'package:wisely/features/expenses/presentation/pages/ExpensesView.dart';
import 'package:wisely/features/expenses/presentation/widgets/Cart_view.dart';
import 'package:wisely/features/incomes/presentation/pages/IncomesView.dart';
import 'package:wisely/features/stats/presentation/widgets/GoalBar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: background_color),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (int i = 0; i < 3; i++)
                          Row(
                            children: [
                              Bcateg_card(),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(
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
                                      (states) => Colors.transparent),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.transparent)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ExpansesView()));
                              },
                              child: CartButton(
                                isexpense: true,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IncomeView()));
                              },
                              style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                  shadowColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.transparent)),
                              child: CartButton(
                                isexpense: false,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: Center(child: GoalBar()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * 0.15 - 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(fontSize: 15, color: text_color),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "ADD +",
                              style:
                                  TextStyle(color: primary_color, fontSize: 15),
                            ))
                      ],
                    ),
                  ),
                  for (int i = 0; i < 5; i++)
                    Column(
                      children: [
                        CategoryCard(
                            title: "title", amount: 2938, icon: "icon"),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
