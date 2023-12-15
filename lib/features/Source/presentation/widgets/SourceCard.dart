import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';
import 'package:wisely/features/Source/domain/entities/Source.dart';

class SourceCard extends StatefulWidget {
  final Source source;
  const SourceCard({super.key, required this.source});

  @override
  State<SourceCard> createState() => _SourceCardState();
}

class _SourceCardState extends State<SourceCard> {
  late Source _source;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _source = widget.source;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
              _source.title,
              style: TextStyle(fontSize: 37, color: primary_color),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: _source.amount.toString(),
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
