import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  // int _rowsPerPage = 100;
  int _pageIndex = 0;
  List<Map<String, dynamic>> _data = [];
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String fromDate = '';
  String toDate = '';
  String transactiontype = 'S03';
  final _datefromController = TextEditingController();
  final _datetoController = TextEditingController();

  Future<void> fetchAuditGeneralLedgerData() async {
    final response = await http.get(
      Uri.parse(
          'http://192.168.1.38:8081/erp/api/osmaster?fromDate=$fromDate&toDate=$toDate&transType=$transactiontype'),
    );
    final List<dynamic> responseData = json.decode(response.body);
    setState(() {
      _data = responseData.map((data) => data as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Data Table'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Container(
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
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: "",
                                  groupValue: transactiontype,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        transactiontype = "";
                                        debugPrint(transactiontype);
                                      },
                                    );
                                  },
                                ),
                                const Text('Export'),
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
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: "S03",
                                  groupValue: transactiontype,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        transactiontype = "S03";
                                        debugPrint(transactiontype);
                                      },
                                    );
                                  },
                                ),
                                const Text('Sales'),
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
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: "",
                                  groupValue: transactiontype,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        transactiontype = "";
                                        debugPrint(transactiontype);
                                      },
                                    );
                                  },
                                ),
                                const Text('Purchase'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // from date picker
                      Row(
                        children: [
                          const Text(
                            'From date :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
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
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // to date picker
                      Row(
                        children: [
                          const Text(
                            'To date :',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
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
                                onTap: () {
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
                        height: 10,
                      ),
                      // elevated button
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              fetchAuditGeneralLedgerData();
                            });
                          },
                          child: const Text('Show List'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: PaginatedDataTable(
                  rowsPerPage: _rowsPerPage,
                  onPageChanged: (pageIndex) {
                    // setState(() {
                    //   _pageIndex = pageIndex;
                    // });
                  },
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Check',
                        style: TextStyle(
                          color: Color.fromARGB(255, 37, 37, 37),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Document No',
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 3, 3),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Document Date',
                        style: TextStyle(
                          color: Color.fromARGB(255, 17, 17, 17),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Account Name',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Currency',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'ROE',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Value',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Cgst Amount',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sgst Amount',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Igst Amount',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Bill Value',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                  source: _MyDataSource(_data, _pageIndex, _rowsPerPage),
                ),
              ),
            ],
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
        lastDate: DateTime(2500));

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
        firstDate: DateTime(2000),
        lastDate: DateTime(2500));
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

class _MyDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;
  final int _pageIndex;
  final int _rowsPerPage;

  _MyDataSource(this._data, this._pageIndex, this._rowsPerPage);

  @override
  DataRow? getRow(int index) {
    final dataIndex = _pageIndex * _rowsPerPage + index;
    if (dataIndex >= _data.length) {
      return null;
    }
    final rowData = _data[dataIndex];
    return DataRow(cells: [
      DataCell(IconButton(
        onPressed: () {},
        icon: Icon(Icons.info_sharp),
        color: Color.fromARGB(255, 115, 209, 233),
      )),
      DataCell(Text(rowData['doc_no'].toString())),
      DataCell(Text(rowData['doc_date'].toString())),
      DataCell(Text(rowData['account_name'])),
      DataCell(Text(rowData['currency'])),
      DataCell(Text(rowData['roe'])),
      DataCell(Text(rowData['totalitem_value'])),
      DataCell(Text(rowData['cgst_amount'])),
      DataCell(Text(rowData['sgst_amount'])),
      DataCell(Text(rowData['igst_amount'])),
      DataCell(Text(rowData['bill_value'])),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
