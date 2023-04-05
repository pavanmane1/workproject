import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<OnlinePayList> onlineList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOnlinePayList();
    onlineList;
    debugPrint('.......................${onlineList.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
            child: Column(
              children: [
                const Text(
                  "Postgres state table",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
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
                        DataColumn(label: Text('trantype')),
                        DataColumn(label: Text('payee')),
                        DataColumn(label: Text('ifsc')),
                        DataColumn(label: Text('ac_no')),
                        DataColumn(label: Text('amount')),
                        DataColumn(label: Text('utrnumber')),
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
        ]),
      ),
    );
  }

  Future<List<OnlinePayList>> fetchOnlinePayList() async {
    // methode to decode json data
    onlineList = [];
    final response = await http.get(Uri.parse(
        'http://192.168.1.45:8081/erp/api/onlinePayment?fromDate=2022-11-01&toDate=2022-11-24&onlinepaymentstatus=SUCCESS'));

    // response.body is String
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List; //converted to dynamic list
      final payList = data.map((e) => OnlinePayList.fromJson(e)).toList();
      debugPrint(
          '+++++++${data.runtimeType}++++${payList[0].trantype}+++${payList[0].payee}+++${payList[0].ifsc}++++${payList[0].ac_no}++++${payList[0].amount}+++${payList[0].utrnumber}++');

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
