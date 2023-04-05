import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/mastertableui.dart';

class Currency extends StatefulWidget {
  final String id;
  Currency({required this.id, Key? key}) : super(key: key);

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  String name = '';
  String code = '';
  String stateid = '';
  String stateCode = '';
  String statename = '';
  List<dynamic> tableData = [];

  @override
  void initState() {
    super.initState();

    countryStateapicall(widget.id).then((data) {
      setState(() {
        tableData = data;
      });
    });
  }

  void _navigatebacktomainscrren() async {
    print("navigation clicked");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => country(),
      ),
    );

    // Handle the result returned by the destination widget if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            //margin: EdgeInsets.only(bottom: ),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                          "States",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          TextEditingController _textEditingController1 = TextEditingController();
                          TextEditingController _textEditingController2 = TextEditingController();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                _textEditingController1.text = '';
                                _textEditingController2.text = '';
                                return AlertDialog(
                                  title: Text("Update fileds"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: _textEditingController1,
                                        onChanged: (value) {},
                                        decoration: InputDecoration(),
                                      ),
                                      TextFormField(
                                        controller: _textEditingController2,
                                        onChanged: (value) {},
                                        decoration: InputDecoration(),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('CANCEL'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          stateCode = _textEditingController1.text;
                                          statename = _textEditingController2.text;
                                          stateid = widget.id;
                                        });

                                        stateDataPostAPICall(stateCode, statename, stateid);
                                        tableData.add({'code': stateCode, 'name': statename});
                                        print(stateCode);
                                        print(statename);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Text('New'),
                      ),
                      ElevatedButton(onPressed: _navigatebacktomainscrren, child: Text("Back"))
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        //alignment: Alignment.,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 105, 105, 105),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DataTable(
                          showBottomBorder: true,
                          dividerThickness: 3.0,
                          columns: const [
                            DataColumn(
                              label: Text('Code'),
                            ),
                            DataColumn(
                              label: Text('Name'),
                            ),
                            DataColumn(
                              label: Text('Edit'),
                            ),
                            DataColumn(
                              label: Text('Delete'),
                            ),
                          ],
                          rows: tableData
                              .map((item) => DataRow(cells: [
                                    //Text(button1Pressed ? item['name'] + ' A' : button2Pressed ? item['name'] + ' B' : item['name']),
                                    DataCell(
                                      Text(item['code'].toString()),
                                    ),
                                    DataCell(
                                      Text(item['name'].toString()),
                                    ),
                                    DataCell(IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Color.fromARGB(255, 56, 56, 56),
                                      onPressed: () {
                                        setState(() {
                                          code = item['code'];
                                          name = item['name'];
                                        });

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Update fileds"),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: TextEditingController(text: code),
                                                    onChanged: (value) {
                                                      code = value;
                                                    },
                                                    decoration: InputDecoration(),
                                                  ),
                                                  TextFormField(
                                                    controller: TextEditingController(text: name),
                                                    onChanged: (value) {
                                                      name = value;
                                                    },
                                                    decoration: InputDecoration(),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('CANCEL'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    stateDataUpdateAPICall(code, item['code'], name);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )),
                                    DataCell(IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Confirm'),
                                              content: Text('Are you sure you want to delete this record?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Delete'),
                                                  onPressed: () {
                                                    stateDataDeleteAPICall(item['code']);
                                                    // TODO: Perform the delete operation
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    )),
                                  ]))
                              .toList(),
                        ),
                      ),
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

  Future<void> stateDataPostAPICall(String code, String name, String countryid) async {
    print("API called");
    print(countryid);
    try {
      var url = Uri.parse("http://192.168.1.45:8081/erp/api/state");
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'code': code,
          'name': name,
          'country_id': countryid,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('${response.body}..............');

        // Handle successful response here
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load post');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load post');
    }
  }

  Future<void> stateDataDeleteAPICall(String code) async {
    print("API called");

    try {
      var url = Uri.parse("http://192.168.1.45:8081/erp/api/state/$code");
      final response = await http.delete(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        print('${response.body}');
        setState(() {
          tableData.removeWhere((country) => country['code'] == code);
        });

        // Handle successful response here
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to delete data');
    }
  }

  Future<void> stateDataUpdateAPICall(String code, String Code, String name) async {
    try {
      var url = Uri.parse("http://192.168.1.45:8081/erp/api/state/$Code");
      final response = await http.put(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        print('${response.body}');
        // Handle successful response here
        final updatedTableData = List<Map<String, dynamic>>.from(tableData);
        final index = updatedTableData.indexWhere((state) => state['code'] == Code);
        if (index != -1) {
          updatedTableData.removeAt(index);
          updatedTableData.insert(index, {'code': code, 'name': name});
        }
        setState(() {
          tableData = updatedTableData;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to update data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to update data');
    }
  }

  Future countryStateapicall(String id) async {
    // methode to decode json data
    final response = await http.get(Uri.parse('http://192.168.1.45:8081/erp/api/state?countryid=$id'));

    // response.body is String
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); //converted to dynamic list
      // List<ProductCode> subjectdetail = data.map((e) => ProductCode.fromJson(e)).toList();

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
