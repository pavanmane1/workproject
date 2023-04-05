/*
 Author: Pavan Mane

 Date: 03th Feb 2023

 Purpose:

*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:myapp/pdfpreview.dart';
import 'package:pdf/widgets.dart' as pdf_doc;
import 'package:flutter/foundation.dart';
import 'package:myapp/displaydate.dart';
import './naDate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum Doctype { pdf, xls }

class DateFilteProvideOption extends StatefulWidget {
  String period;
  DateFilteProvideOption({required this.period, Key? key}) : super(key: key);

  @override
  State<DateFilteProvideOption> createState() => _DateFilteProvideOptionState();
}

class _DateFilteProvideOptionState extends State<DateFilteProvideOption> {
  late TextEditingController _fromdateController;
  late TextEditingController _todateController;
  var firstdate = firstDate(DateFormat("dd-MM-yyyy").format(DateTime.now()));
  var lastdate = lastDate(DateFormat("dd-MM-yyyy").format(DateTime.now()));
  Doctype? _doctype;
  String fromDate = '';
  String toDate = '';
  var yearfirstdate;
  String financialFirstdate = "";
  String financialLastDate = '';
  String _selectedValue = 'PDF';

  final Map<Doctype, String> _doctypeMap = {
    Doctype.pdf: 'PDF',
    Doctype.xls: 'XLS',
  };

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse('http://192.168.1.38:8081/erp/api/calendardate'));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      yearfirstdate = data.map((e) => fromTodate.fromJson(e)).toList();
      financialFirstdate = yearfirstdate[0].firstdate.toString();
      financialLastDate = yearfirstdate[0].lastdate.toString();
      setState(() {
        _fromdateController = TextEditingController(text: financialFirstdate.substring(0, 10));
        _todateController = TextEditingController(text: financialLastDate.substring(0, 10));
        fromDate = _fromdateController.text;
        toDate = _todateController.text;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();

    if (widget.period == "M") {
      _fromdateController = TextEditingController(text: firstdate);
      _todateController = TextEditingController(text: lastdate);
      fromDate = _fromdateController.text;
      toDate = _todateController.text;
    } else if (widget.period == "Y") {
      _fromdateController = TextEditingController(text: financialFirstdate);
      _todateController = TextEditingController(text: financialLastDate);
      apicall();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Datefilterwithoption")),
      body: Container(
        height: 450,
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                'From Date',
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
                  controller: _fromdateController,
                  readOnly: true,
                  onChanged: (value) {
                    debugPrint(_fromdateController.text);
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      controller: _todateController,
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
                          return '\u26A0 select value';
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RadioMenuButton<Doctype>(
                    value: Doctype.pdf,
                    groupValue: _doctype,
                    onChanged: (value) {
                      setState(() {
                        _doctype = value;
                        _selectedValue = _doctypeMap[value]!;
                      });
                    },
                    child: const Text("PDF")),
                RadioMenuButton<Doctype>(
                    value: Doctype.xls,
                    groupValue: _doctype,
                    onChanged: (value) {
                      setState(() {
                        _doctype = value;
                        _selectedValue = _doctypeMap[value]!;
                      });
                    },
                    child: const Text("XLS"))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      setState(() {});
                    },
                    child: const Text('Go'),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  //width: 170,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_doctype == Doctype.pdf) {
                        Uint8List pdf = await generatePdf(fromDate, toDate);
                        await Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PdfPreviewpage(
                                  pdf_doc: pdf,
                                )));
                      }
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
        _fromdateController.text = DateFormat('yyyy-MM-dd').format(fromPicked);
        fromDate = _fromdateController.text;
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
        _todateController.text = DateFormat('yyyy-MM-dd').format(toPicked);
        toDate = _todateController.text;
      });
    } else {
      debugPrint('not selected..');
    }
  }
}

class fromTodate {
  fromTodate({
    required this.firstdate,
    required this.lastdate,
  });

  DateTime firstdate;
  DateTime lastdate;

  factory fromTodate.fromJson(Map<String, dynamic> json) => fromTodate(
        firstdate: DateTime.parse(json["firstdate"]),
        lastdate: DateTime.parse(json["lastdate"]),
      );

  Map<String, dynamic> toJson() => {
        "firstdate": firstdate.toIso8601String(),
        "lastdate": lastdate.toIso8601String(),
      };
}

Future<Uint8List> generatePdf(fromdate, todate) async {
  final pdf = pdf_doc.Document();

  pdf.addPage(
    pdf_doc.Page(
      build: (context) {
        return pdf_doc.Container(
            child: pdf_doc.Column(children: [
          pdf_doc.Text("Invoice",
              style: pdf_doc.TextStyle(fontWeight: pdf_doc.FontWeight.bold, fontSize: 40),
              textAlign: pdf_doc.TextAlign.center),
          pdf_doc.SizedBox(height: 10),
          pdf_doc.Row(mainAxisAlignment: pdf_doc.MainAxisAlignment.spaceBetween, children: [
            pdf_doc.Column(crossAxisAlignment: pdf_doc.CrossAxisAlignment.start, children: [
              pdf_doc.Text("Pavan bhimrao mane", textAlign: pdf_doc.TextAlign.left),
              pdf_doc.Text("pavanmane4961@gmaoil.com", textAlign: pdf_doc.TextAlign.left),
              pdf_doc.Text("+91 9146255857", textAlign: pdf_doc.TextAlign.left),
              pdf_doc.Text("a/p sangavade tal- karvir", textAlign: pdf_doc.TextAlign.left),
            ]),
            pdf_doc.Column(
              children: <pdf_doc.Widget>[
                pdf_doc.Text("fromdate: $fromdate"),
                pdf_doc.Text("todadte: $todate"),
              ],
            ),
          ]),
          pdf_doc.SizedBox(height: 40),
          pdf_doc.Divider(),
          pdf_doc.SizedBox(height: 20),
          pdf_doc.Table(children: [
            pdf_doc.TableRow(children: [
              pdf_doc.Text("Item"),
              pdf_doc.Text("Quantity"),
              pdf_doc.Text("Price"),
              pdf_doc.Text("PartNo"),
              pdf_doc.Text("HSN"),
              pdf_doc.Text("row"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("shoes"),
              pdf_doc.Text("100"),
              pdf_doc.Text("500"),
              pdf_doc.Text("21545"),
              pdf_doc.Text("84545"),
              pdf_doc.Text("5451"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("glubs"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("socks"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("shirt"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("pant"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
            pdf_doc.TableRow(children: [
              pdf_doc.Text("bags"),
              pdf_doc.Text("21214"),
              pdf_doc.Text("4547"),
              pdf_doc.Text("151"),
              pdf_doc.Text("8484"),
              pdf_doc.Text("1454"),
            ]),
          ]),
          pdf_doc.Divider(),
          pdf_doc.SizedBox(height: 60),
          pdf_doc.Row(
            mainAxisAlignment: pdf_doc.MainAxisAlignment.end,
            children: <pdf_doc.Widget>[
              pdf_doc.Text("total"),
              pdf_doc.Text(""),
            ],
          ),
        ]));
      },
    ),
  );
  return pdf.save();
}
