import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final String icon;
  const CategoryCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.icon});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late String title = widget.title;
  late String icon = widget.icon;
  late double amount = widget.amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          color: primary_color,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFFD3F9B5),
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "1491",
                  style: TextStyle(fontSize: 35, color: tertiary_color)),
              TextSpan(
                  text: ".00",
                  style: TextStyle(fontSize: 25, color: tertiary_color)),
              TextSpan(
                  text: " dz",
                  style: TextStyle(fontSize: 20, color: text_color))
            ]),
          ),
          SizedBox(
            width: 7,
          ),
          Icon(
            Icons.train,
            color: Colors.white,
            size: 50,
          )
        ],
      ),
    );
  }
}
