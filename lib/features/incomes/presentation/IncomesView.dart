import 'package:flutter/material.dart';

class IncomeView extends StatefulWidget {
  const IncomeView({super.key});

  @override
  State<IncomeView> createState() => _IncomeViewState();
}

class _IncomeViewState extends State<IncomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Income Page : ) ")),
    );
  }
}
