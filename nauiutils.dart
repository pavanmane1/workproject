/*
 Author: Pavan Mane

 Date: 27th Jan 2023

 Purpose:

*/
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

/* class ArrayList {
  String id, name;
  ArrayList({required this.id, required this.name});
}

class Dropdowns extends StatefulWidget {
  final List<String> array;
  final String? defaultValue;
  final void Function(String)? onChanged;
  Dropdowns({required this.array, this.onChanged, this.defaultValue, Key? key}) : super(key: key);

  @override
  State<Dropdowns> createState() => _DropdownsState();
}

class _DropdownsState extends State<Dropdowns> {
  late String selectedValue;
  @override
  void initState() {
    selectedValue = widget.defaultValue ?? widget.array.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: widget.array.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
          widget.onChanged?.call(newValue!);
        },
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        isExpanded: true,
      ),
    );
  }
} */

/* class ArrayList {
  String id, name;
  ArrayList({required this.id, required this.name});
}

class Dropdowns extends StatefulWidget {
  final List<ArrayList> array;
  final int defaultValue;
  final void Function(String)? onChanged;
  const Dropdowns({required this.array, this.onChanged,required this.defaultValue, Key? key}) : super(key: key);

  @override
  State<Dropdowns> createState() => _DropdownsState();
}

class _DropdownsState extends State<Dropdowns> {
  late String selectedValue;
   @override
  void initState() {
   // selectedValue = widget.defaultValue ?? widget.array;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownSearch(
        selectedItem: widget.array[widget.defaultValue],
        popupProps: const PopupProps.menu(fit: FlexFit.loose
            //showSearchBox: true,
            ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: 'select value',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        // selectedItem: selectedValue,
        items: widget.array,

        itemAsString: (item) => item.name,
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue!.name;
          });
          widget.onChanged?.call(newValue!.name);
        },
      ),
    );
  }
}
 */
class ArrayList {
  String id, name;
  ArrayList({required this.id, required this.name});
}

class Dropdowns extends StatefulWidget {
  final List<ArrayList> array;
  final int defaultValueIndex;
  final void Function(String)? onChanged;
  const Dropdowns({required this.array, required this.onChanged, required this.defaultValueIndex, Key? key})
      : super(key: key);

  @override
  State<Dropdowns> createState() => _DropdownsState();
}

class _DropdownsState extends State<Dropdowns> {
  late String selectedValue;
  @override
  void initState() {
    // selectedValue = widget.defaultValue ?? widget.array;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: DropdownSearch(
        selectedItem: widget.array[widget.defaultValueIndex],
        popupProps: const PopupProps.menu(fit: FlexFit.loose
            //showSearchBox: true,
            ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: 'select value',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        itemAsString: (item) => item.name.toString(),
        items: widget.array.toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue!.name;
          });
          widget.onChanged?.call(newValue!.name);
        },
      ),
    );
  }
}
