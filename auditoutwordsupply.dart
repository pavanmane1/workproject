import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Auditoutwordsupply extends StatefulWidget {
  Auditoutwordsupply({Key? key}) : super(key: key);

  @override
  State<Auditoutwordsupply> createState() => _AuditoutwordsupplyState();
}

class _AuditoutwordsupplyState extends State<Auditoutwordsupply> {
  int _pageIndex = 0;
  List<Map<String, dynamic>> _data = [];
  final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isCheckselect = false;
  bool istablebackbutton = false;
  List<Map<String, dynamic>> tableData = [];
  String transactiontype = 'S03';
  final _datefromController = TextEditingController();
  final _datetoController = TextEditingController();
  String fromDate = '';
  String toDate = '';
  String _id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Audit Outward Supply")),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              height: 350,
              width: 400,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(88, 177, 220, 255),
                  border: Border.all(color: const Color.fromARGB(190, 0, 0, 0)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
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
                    height: 20,
                  ),
                  Container(
                    child: Row(
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
                  ),
                  const SizedBox(
                    height: 40,
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
                          onPressed: () async {
                            setState(() {
                              istablebackbutton = true;
                            });
                            await auditoutwordsupplyGetApi(fromDate, toDate, transactiontype);
                          },
                          child: const Text('show'),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        //width: 170,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: isCheckselect,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(125, 129, 205, 235),
                  ),
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        isCheckselect = false;
                        istablebackbutton = true;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: istablebackbutton,
            child: SingleChildScrollView(
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
                source: _MyDataSource(_data, _pageIndex, _rowsPerPage, setId),
              ),
            ),
          ),
          Visibility(
            visible: isCheckselect,
            child: SingleChildScrollView(
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
                      'Product Code',
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Product Discription',
                      style: TextStyle(
                        color: Color.fromARGB(255, 17, 17, 17),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Quantity',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'UOM Code',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Rate',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Taxable',
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
                      'Value',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
                source: _MyDataSourcedetailddata(
                  tableData,
                  _pageIndex,
                  _rowsPerPage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setId(String id) {
    setState(() {
      _id = id;
      isCheckselect = true;
      istablebackbutton = false;
    });
    auditoutwordsupplydetailGetApi(_id);
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

  Future<List<Map<String, dynamic>>?> auditoutwordsupplyGetApi(
      String fromDate, String toDate, String transactiontype) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.38:8081/erp/api/osmaster?fromDate=$fromDate&toDate=$toDate&transType=$transactiontype'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _data = responseData.map((data) => data as Map<String, dynamic>).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> auditoutwordsupplydetailGetApi(String id) async {
    print(id);
    final response = await http.get(Uri.parse('http://192.168.1.38:8081/erp/api/osdetail?pid=$id'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        tableData = responseData.map((data) => data as Map<String, dynamic>).toList();
      });

      return null;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class _MyDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;
  final int _pageIndex;
  final int _rowsPerPage;
  String _id = '';
  Function(String) setId;
  _MyDataSource(this._data, this._pageIndex, this._rowsPerPage, this.setId);

  @override
  DataRow? getRow(int index) {
    final dataIndex = _pageIndex * _rowsPerPage + index;
    if (dataIndex >= _data.length) {
      return null;
    }
    final rowData = _data[dataIndex];
    return DataRow(cells: [
      DataCell(IconButton(
        onPressed: () {
          _id = rowData['hid'].toString();
          setId(rowData['hid'].toString());
        },
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

class takeid {
  String _id = '';

  void setId(String id) {
    _id = id;
  }
}

class _MyDataSourcedetailddata extends DataTableSource {
  final List<Map<String, dynamic>> tableData;
  final int _pageIndex;
  final int _rowsPerPage;

  _MyDataSourcedetailddata(
    this.tableData,
    this._pageIndex,
    this._rowsPerPage,
  );

  @override
  DataRow? getRow(int index) {
    final dataIndex = _pageIndex * _rowsPerPage + index;
    if (dataIndex >= tableData.length) {
      return null;
    }
    final rowData = tableData[dataIndex];
    return DataRow(cells: [
      DataCell(Text(rowData['product_code'].toString())),
      DataCell(Text(rowData['product_description'].toString())),
      DataCell(Text(rowData['quantity'].toString())),
      DataCell(Text(rowData['uom_code'].toString())),
      DataCell(Text(rowData['rate'].toString())),
      DataCell(Text(rowData['taxable'].toString())),
      DataCell(Text(rowData['cgst_amount'].toString())),
      DataCell(Text(rowData['item_value'].toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tableData.length;

  @override
  int get selectedRowCount => 0;
}
