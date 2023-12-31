import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final int? icon;
  CategoryCard(
      {super.key, required this.title, required this.amount, this.icon});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late String title = widget.title;
  late int? icon = widget.icon;
  late double amount = widget.amount;

  @override
  Widget build(BuildContext context) {
    print("this is the icon data ${icon!}");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  text: amount.toInt().toString(),
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
            icon != null ? IconData(icon!, fontFamily: "MaterialIcons") : null,
            color: Colors.white,
            size: 50,
          )
        ],
      ),
    );
  }
}
