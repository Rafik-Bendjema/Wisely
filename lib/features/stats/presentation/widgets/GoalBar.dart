import 'package:flutter/material.dart';

import '../../../../core/resources/colors.dart';

class GoalBar extends StatefulWidget {
  const GoalBar({super.key});

  @override
  State<GoalBar> createState() => _GoalBarState();
}

class _GoalBarState extends State<GoalBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  void load() async {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      setState(() {
        _capacity = 200;
      });
    });
  }

  double _capacity = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "13487",
                    style: TextStyle(fontSize: 15, color: Colors.red)),
                TextSpan(
                    text: ".00",
                    style: TextStyle(fontSize: 10, color: Colors.red)),
                TextSpan(
                    text: " dz",
                    style: TextStyle(fontSize: 5, color: text_color))
              ]),
            ),
            TextButton(onPressed: () {}, child: Text("edit"))
          ],
        ),
        Stack(children: [
          Container(
            decoration: BoxDecoration(
                color: secondary_color,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: 50,
            height: 300,
          ),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                  color: primary_color,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 50,
              height: _capacity,
            ),
          ),
        ]),
      ],
    );
  }
}
