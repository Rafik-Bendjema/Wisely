import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';

class Bcateg_card extends StatefulWidget {
  const Bcateg_card({super.key});

  @override
  State<Bcateg_card> createState() => _Bcateg_cardState();
}

class _Bcateg_cardState extends State<Bcateg_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.all(15),
      height: 150,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "global",
              style: TextStyle(fontSize: 37, color: primary_color),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "1491",
                    style: TextStyle(fontSize: 40, color: tertiary_color)),
                TextSpan(
                    text: ".00",
                    style: TextStyle(fontSize: 30, color: tertiary_color)),
                TextSpan(
                    text: " dz",
                    style: TextStyle(fontSize: 25, color: text_color))
              ]),
            ),
          )
        ],
      ),
    );
  }
}
