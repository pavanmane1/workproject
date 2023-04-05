import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class OnlinePayment extends StatefulWidget {
  const OnlinePayment({super.key});

  @override
  State<OnlinePayment> createState() => _OnlinePaymentState();
}

class _OnlinePaymentState extends State<OnlinePayment> {
  late List<OnlinePayList> onlineList;

  String fromDate = '';
  String toDate = '';

  // String trantype = '';
  // String payee = '';
  // String ac_no = '';
  // String ifsc = '';
  // String utrnumber = '';
  // String amount = '';

  final _datefromController = TextEditingController();
  final _datetoController = TextEditingController();
  String payStatus = 'PENDING';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOnlinePayList();
    onlineList;
    fromDate = _datefromController.text;
    toDate = _datetoController.text;

    // debugPrint('....%%%%......${onlineList.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  //margin: EdgeInsets.only(bottom: ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      color: const Color.fromARGB(86, 236, 236, 236),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "View online payments",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //radio button

                Container(
                  width: 500,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      color: const Color.fromARGB(88, 177, 220, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(125, 129, 205, 235),
                            ),
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: "PENDING",
                                  groupValue: payStatus,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        payStatus = "PENDING";
                                        debugPrint(payStatus);
                                      },
                                    );
                                  },
                                ),
                                const Text('Pending'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(125, 129, 205, 235),
                            ),
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: "FAILURE",
                                  groupValue: payStatus,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        payStatus = "FAILURE";
                                        debugPrint(payStatus);
                                      },
                                    );
                                  },
                                ),
                                const Text('failed'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(125, 129, 205, 235),
                            ),
                            child: Row(
                              children: [
                                Radio(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: "SUCCESS",
                                  groupValue: payStatus,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        payStatus = "SUCCESS";
                                        debugPrint(payStatus);
                                      },
                                    );
                                  },
                                ),
                                const Text('Success'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // app date picker
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'From date :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // exp date picker
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'To date :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 180,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              fetchOnlinePayList();
                              onlineList;
                              debugPrint(onlineList.toString());
                            });
                          },
                          child: const Text('Show List'),
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      horizontalMargin: 0,
                      border: TableBorder.symmetric(),
                      headingTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      columns: const [
                        DataColumn(
                            label: Text(
                          'TranType',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 85, 235),
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Payee',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 85, 235),
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'IFSC',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 85, 235),
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'A/C NO.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 85, 235),
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'Amount',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 85, 235),
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'UTR NO.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 85, 235),
                          ),
                        )),
                      ],
                      rows: onlineList
                          .map(
                            (list) => DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    list.trantype.toString(),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    list.payee.toString(),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    list.ifsc.toString(),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    list.ac_no.toString(),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    list.amount.toString(),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    list.utrnumber.toString(),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Calendar for from date
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

// Calendar for to date
  _toDate(BuildContext context) async {
    final DateTime? toPicked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),        lastDate: DateTime(2200));
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

  // get payment list from rest api
  Future<List<OnlinePayList>> fetchOnlinePayList() async {
    // methode to decode json data
    onlineList = [];
    var url =
        'http://erpx.datta-india.co.in:8081/erp/api/onlinePayment?fromDate=$fromDate&toDate=$toDate&onlinepaymentstatus=$payStatus';
    debugPrint('.....%%%.......$url');

    final response = await http.get(Uri.parse(url));

    // response.body is String
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List; //converted to dynamic list
      List<OnlinePayList> payList =
          data.map((e) => OnlinePayList.fromJson(e)).toList();
      // debugPrint(
      //     '+++++++${data.runtimeType}++++${payList[0].trantype}+++${payList[0].payee}+++${payList[0].ifsc}++++${payList[0].ac_no}++++${payList[0].amount}+++${payList[0].utrnumber}++');

      debugPrint('+++++++${response.statusCode}++');
      for (final row in payList) {
        setState(() {
          onlineList.add(OnlinePayList(
            trantype: row.trantype,
            payee: row.payee,
            ifsc: row.ifsc,
            ac_no: row.ac_no,
            amount: row.amount,
            utrnumber: row.utrnumber,
          ));
        });
      }

      return payList;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class OnlinePayList {
  String? trantype;
  String? payee;
  String? ifsc;
  String? ac_no;
  String? amount;
  String? utrnumber;

  OnlinePayList(
      {this.trantype,
      this.payee,
      this.ifsc,
      this.ac_no,
      this.amount,
      this.utrnumber});

  factory OnlinePayList.fromJson(Map<String, dynamic> json) => OnlinePayList(
        trantype: json["trantype"],
        payee: json["payee"],
        ifsc: json["ifsc"],
        ac_no: json["ac_no"],
        amount: json["amount"],
        utrnumber: json["utrnumber"],
      );
}





// http://192.168.1.45:8081/erp/api/onlinePayment?fromDate=2022-11-01&toDate=2022-11-24&onlinepaymentstatus=SUCCESS





