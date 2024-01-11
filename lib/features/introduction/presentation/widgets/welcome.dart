import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisely/core/resources/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                  style: TextStyle(fontSize: 25, color: text_color),
                  text: "wecome to",
                  children: [
                    TextSpan(
                        text: " Wisely",
                        style: TextStyle(color: primary_color, fontSize: 30))
                  ]),
            ),
            SizedBox(
              width: 200,
              child: SvgPicture.asset(
                'assets/images/welcomePage.svg',
                semanticsLabel: "HERE IS THE LOGO",
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(fontSize: 25, color: text_color),
                  text: "where you can Manage your budget ",
                  children: [
                    TextSpan(
                        text: " Wisely",
                        style: TextStyle(color: primary_color, fontSize: 30))
                  ]),
            ),
          ],
        ));
  }
}
