import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';

Widget dividers(String day) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          day,
          style: TextStyle(color: text_color, fontSize: 20),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Align(
          alignment: Alignment.center,
          child: Divider(
            color: text_color,
          ),
        ))
      ],
    );
