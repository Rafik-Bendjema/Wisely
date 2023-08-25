import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';

Widget expenseTile(BuildContext context, String title, int price) => Container(
      padding: EdgeInsets.all(10),
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: TextStyle(color: text_color, fontSize: 20),
        ),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: price.toString(),
                style: TextStyle(fontSize: 25, color: primary_color)),
            TextSpan(
                text: ".00",
                style: TextStyle(fontSize: 15, color: primary_color)),
            TextSpan(
                text: " dz", style: TextStyle(fontSize: 10, color: text_color))
          ]),
        ),
      ]),
    );
