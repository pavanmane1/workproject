import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late String selectedValue;
  @override
  void initState() {
    // selectedValue = widget.defaultValue ?? widget.array;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Container(
        width: 100,
        child: DropdownSearch(),
      ),
    )));
  }
}
