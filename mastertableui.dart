import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:myapp/mastertableui.dart';
import 'package:myapp/state.dart';
import 'package:myapp/statetable.dart';

class country extends StatefulWidget {
  country({Key? key}) : super(key: key);

  @override
  State<country> createState() => _countryState();
}

class _countryState extends State<country> {
  String id = '';
  String code = '';
  String name = '';
  List<dynamic> tableData = [];
  @override
  void initState() {
    super.initState();
    countryGetApiCall().then((data) {
      setState(() {
        tableData = data;
      });
    });
  }

  void _navigateToDestinationWidget() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => countrydetail(
          id: id,
        ),
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
                          'country',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          TextEditingController _countrycodecontroller = TextEditingController();
                          TextEditingController _countrynamecontroller = TextEditingController();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                _countrycodecontroller.text = '';
                                _countrynamecontroller.text = '';
                                return AlertDialog(
                                  title: Text("Create filed"),
                                  content: Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            controller: _countrycodecontroller,
                                            onChanged: (value) {},
                                            decoration: InputDecoration(
                                              labelText: 'countrycode',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              hintStyle: const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            controller: _countrynamecontroller,
                                            onChanged: (value) {},
                                            decoration: InputDecoration(
                                              labelText: 'countryname',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              hintStyle: const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    SingleChildScrollView(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('CANCEL'),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          code = _countrycodecontroller.text;
                                          name = _countrynamecontroller.text;
                                        });
                                        countryDataPostAPICall(code, name);
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
                            DataColumn(
                              label: Text('details'),
                            ),
                          ],
                          rows: tableData
                              .map((item) => DataRow(cells: [
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
                                                    decoration: InputDecoration(
                                                      labelText: 'countrycode',
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      hintStyle: const TextStyle(fontSize: 15),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextFormField(
                                                    controller: TextEditingController(text: name),
                                                    onChanged: (value) {
                                                      name = value;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: 'countryname',
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      hintStyle: const TextStyle(fontSize: 15),
                                                    ),
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
                                                    print(code);
                                                    print(name);
                                                    print("clicked ok");
                                                    countryDataUpdateAPICall(item['code'], code, name);
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
                                                  onPressed: () async {
                                                    setState(() {
                                                      code = item['code'];
                                                      name = item['name'];
                                                    });
                                                    print(code);
                                                    countryDataDeleteAPICall(item['code']);
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
                                    DataCell(IconButton(
                                      icon: Icon(Icons.info_sharp),
                                      color: Color.fromARGB(255, 115, 209, 233),
                                      onPressed: () {
                                        setState(() {
                                          id = item['id'];
                                        });
                                        print(id);
                                        _navigateToDestinationWidget();
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

  Future<void> countryDataPostAPICall(
    String code,
    String name,
  ) async {
    try {
      if (code.isEmpty || name.isEmpty) {
        // Don't save empty data
        return;
      }
      var url = Uri.parse("http://192.168.1.45:8081/erp/api/country");
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'code': code,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('${response.body}..............');
        setState(() {
          tableData.add({
            'code': code,
            'name': name,
          });
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record Added successfully'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
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

  Future countryGetApiCall() async {
    // methode to decode json data
    final response = await http.get(Uri.parse('http://192.168.1.45:8081/erp/api/country'));

    // response.body is String
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); //converted to dynamic list
      // List<ProductCode> subjectdetail = data.map((e) => ProductCode.fromJson(e)).toList();

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> countryDataUpdateAPICall(
    String Code,
    String code,
    String name,
  ) async {
    try {
      var url = Uri.parse("http://192.168.1.45:8081/erp/api/country/$Code");
      final response = await http.put(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'code': code,
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        print('${response.body}');
        final updatedTableData = List<Map<String, dynamic>>.from(tableData);
        final index = updatedTableData.indexWhere((country) => country['code'] == Code);
        if (index != -1) {
          updatedTableData.removeAt(index);
          updatedTableData.insert(index, {
            'code': code,
            'name': name,
          });
        }
        setState(() {
          tableData = updatedTableData;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to update data');
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Record Updated successfully'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to update data');
    }
  }

  Future<void> countryDataDeleteAPICall(String code) async {
    print("API called");

    try {
      var url = Uri.parse("http://192.168.1.45:8081/erp/api/country/$code");
      final response = await http.delete(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        print('${response.body}');
        setState(() {
          tableData.removeWhere((country) => country['code'] == code);
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record deleted successfully'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to delete data');
    }
  }
}
/*  List<dynamic> itemList = item as List<dynamic>;
                          Set<String> docDate = '' as Set<String>;
                          // Set<String> suppliername = '' as Set<String>;
                          // Set<String> refDocumentNo = '' as Set<String>;
                          // Set<String> poDate = '' as Set<String>;
                          itemList.forEach((element) {
                            docDate.add(element['documentdate']);
                            // suppliername.add(element['name']);
                            // refDocumentNo.add(element['referancedocumentnumber']);
                            // poDate.add(element['referancedocumentdate']);
                          });
                          // String poDateString = poDate.toList().join(', ');
                          String docDateString = docDate.toList().join(', ');
                          // String suppliernameString = suppliername.toList().join(', ');
                          // String refDocumentNoString = refDocumentNo.toList().join(', ');
                          // referanceDocumentNocontroller.text = refDocumentNoString;
                          // suppliername = suppliernameString as Set<String>;
                          datecontroller.text = docDateString;
                          // poDatecontroller.text = poDateString;
                          print(referanceDocumentNocontroller.text);
                          print(suppliername);
                          print(datecontroller.text);
                          print(poDatecontroller.text); */