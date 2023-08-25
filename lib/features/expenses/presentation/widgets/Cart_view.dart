import 'package:flutter/material.dart';
import 'package:wisely/core/resources/colors.dart';

class CartButton extends StatefulWidget {
  bool isexpense;
  CartButton({super.key, required this.isexpense});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: 150,
          height: 150,
          child: Center(
            child: Text(
              widget.isexpense ? "Expanses" : "incomes",
              style: TextStyle(fontSize: 30, color: primary_color),
            ),
          ),
        ),
        Positioned(
          top: 0,
          width: 50,
          right: -25,
          child: Icon(
            widget.isexpense ? Icons.arrow_circle_down : Icons.arrow_circle_up,
            color: widget.isexpense ? Colors.red : Colors.green,
            size: 50,
          ),
        )
      ],
    );
  }
}
