import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/colors.dart';

class FeaturesTwo extends StatelessWidget {
  const FeaturesTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  text: "make it more orginized\nusing the \n",
                  style: TextStyle(fontSize: 30, color: text_color),
                  children: [
                    TextSpan(
                        text: "Source \n",
                        style: TextStyle(color: primary_color)),
                    const TextSpan(text: "and \n"),
                    TextSpan(
                        text: "Category \n",
                        style: TextStyle(color: primary_color)),
                    TextSpan(
                        text:
                            "and set goals to challenge your self and save money ",
                        style: TextStyle(color: text_color)),
                  ]),
            ),
            SvgPicture.asset(
              'assets/images/feature2.svg',
              width: 250,
            )
          ],
        ));
  }
}
