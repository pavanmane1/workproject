/*
 Author: Pavan Mane

 Date: 03th Feb 2023

 Purpose:

*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/datefilterwithoption.dart';
import 'package:myapp/displaydate.dart';

class Datefilter extends StatefulWidget {
  const Datefilter({Key? key}) : super(key: key);

  @override
  State<Datefilter> createState() => _DatefilterState();
}

class _DatefilterState extends State<Datefilter> {
  final _datefromController = TextEditingController();
  final _datetoController = TextEditingController();
  String fromDate = '';
  String toDate = '';
  String? gender;
  @override
  void initState() {
    super.initState();
    fromDate = _datefromController.text;
    toDate = _datetoController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DateFilter")),
      body: Container(
        height: 350,
        //margin: const EdgeInsets.all(15.0),
        //padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(164, 144, 202, 249),
            border: Border.all(color: const Color.fromARGB(190, 0, 0, 0)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'From date :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 190,
                    child: TextFormField(
                      onTap: () async {
                        setState(() {
                          _fromDate(context);
                        });
                      },
                      controller: _datefromController,
                      readOnly: true,
                      onChanged: (value) {
                        debugPrint(_datefromController.text);
                      },
                      decoration: InputDecoration(
                        hintText: fromDate,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: const TextStyle(fontSize: 15),
                        suffixIcon: const Icon(
                          Icons.calendar_month,
                          size: 23,
                          color: Colors.blueAccent,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '\u26A0 select date';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ]),
            const SizedBox(
              height: 30,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'To date :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                    width: 190,
                    child: TextFormField(
                      autofocus: false,
                      readOnly: true,
                      controller: _datetoController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Icon(
                          Icons.calendar_month,
                          size: 23,
                          color: Colors.blueAccent,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      onTap: () async {
                        // await _toDate(context);
                        setState(() {
                          _toDate(context);
                        });
                      },
                      onChanged: (toDate) {
                        debugPrint(toDate);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '\u26A0 select date';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    )),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 90,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 150,
                  padding: const EdgeInsets.all(3.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Displaydate(
                                    optionType: "",
                                    fromDate: fromDate,
                                    Todate: toDate,
                                  )));
                      setState(() {});
                    },
                    child: const Text('Go'),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  //width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Datefilterwithoption(
                                    label: "Output Type",
                                    option1: "PDF",
                                    option2: "XLS",
                                    period: "Y",
                                  )));
                      setState(() {});
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _fromDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? fromPicked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime(now.year, now.month, 1),
        firstDate: DateTime(2000),
        lastDate: DateTime(2200));

    if (fromPicked != null) {
      debugPrint(fromPicked.toString());
      setState(() {
        _datefromController.text = DateFormat('yyyy-MM-dd').format(fromPicked);
        fromDate = _datefromController.text;
      });
    } else {
      debugPrint('not selected..');
    }
  }

  _toDate(BuildContext context) async {
    final DateTime? toPicked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2200));
    if (toPicked != null) {
      debugPrint(toPicked.toString());
      setState(() {
        _datetoController.text = DateFormat('yyyy-MM-dd').format(toPicked);
        toDate = _datetoController.text;
      });
    } else {
      debugPrint('not selected..');
    }
  }
}
