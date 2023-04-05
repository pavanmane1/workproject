import 'package:flutter/material.dart';

class Displaydate extends StatelessWidget {
  final String fromDate;
  final String Todate;
  final String optionType;

  Displaydate({Key? key, required this.fromDate, required this.Todate, required this.optionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Display date"),
          ),
          body: Column(children: [
            Text(fromDate),
            Text(Todate),
            Text(optionType as String),
          ])),
    );
  }
}
