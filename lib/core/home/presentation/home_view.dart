import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';
import 'package:wisely/features/budget_categ/presentation/widgets/Bcateg_Card.dart';
import 'package:wisely/features/expenses/presentation/widgets/Cart_view.dart';

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
                          CartButton(
                            isexpense: true,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CartButton(
                            isexpense: false,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Center(
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: secondary_color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: 50,
                          height: 300,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: primary_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: 50,
                            height: 200,
                          ),
                        ),
                      ]),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
