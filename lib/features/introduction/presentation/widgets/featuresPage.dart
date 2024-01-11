import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisely/core/resources/colors.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  text: "keep track of your \n",
                  style: TextStyle(fontSize: 30, color: text_color),
                  children: [
                    TextSpan(
                        text: "incomes \n",
                        style: TextStyle(color: primary_color)),
                    const TextSpan(text: "and \n"),
                    TextSpan(
                        text: "outcomes ",
                        style: TextStyle(color: primary_color)),
                  ]),
            ),
            SvgPicture.asset(
              'assets/images/feature1.svg',
              width: 250,
            )
          ],
        ));
  }
}
