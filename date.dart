import 'dart:convert';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalesOrder extends StatefulWidget {
  const SalesOrder({super.key});

  @override
  State<SalesOrder> createState() => _SalesOrderState();
}

class _SalesOrderState extends State<SalesOrder> {
  List<DataRow> datarows = [];
  late Future<List<ProductCode>> prodCode;
  String productcodeKEY = '';
  String descriptioncodeKEY = '';
  String pricecodeKEY = '';
  String quantity = '1';
  String value = '';

  final _valueController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    value = _valueController.text;
    super.initState();
    prodCode = productC();
  }

  // void _removeColumn(String oldrow) {
  //   if (datarows.length == 1 || !datarows.contains(oldrow)) {
  //     return;
  //   }
  //   setState(() {
  //     for (var i = 0; i <= datarows.length - 1; i++) {
  //       datarows[i].remove(oldrow);
  //     }
  //     datarows.remove(oldrow);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Order'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Column(
            children: [
              DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      "SrNo.",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        // color: kBlack,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      "Prod. Code",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      "Description",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        // color: kBlack,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      "Quantity",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      "Price",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        // color: kBlack,
                      ),
                    ),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text(
                      "Value",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                    numeric: true,
                  ),
                  // DataColumn(
                  //   label: Text(
                  //     "  ",
                  //     style: TextStyle(
                  //       fontStyle: FontStyle.italic,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   numeric: true,
                  // ),
                ],
                rows: datarows,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        datarows.add(
                          DataRow(
                            cells: [
                              const DataCell(Text('*')),
                              DataCell(
                                Container(
                                  width: 160,
                                  height: 120,
                                  child: FutureBuilder<List<ProductCode>>(
                                      future: prodCode,
                                      builder: (BuildContext context, snapshot) {
                                        if (snapshot.hasData) {
                                          return DropdownSearch<ProductCode>(
                                            popupProps: const PopupProps.menu(),
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                labelText: "Code",
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                              ),
                                            ),
                                            itemAsString: (ProductCode? p) => p!.code.toString(),
                                            items: snapshot.data!.toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                productcodeKEY = val!.code.toString();
                                                debugPrint(productcodeKEY.toString());
                                                descriptioncodeKEY = val.description.toString();
                                                pricecodeKEY = val.price.toString();
                                                debugPrint("$descriptioncodeKEY,,,,$pricecodeKEY,,,,,$productcodeKEY");
                                              });
                                            },
                                            validator: (value) => value == null ? 'field required' : null,
                                            // autoValidateMode:,
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                ),
                              ),
                              DataCell(
                                Container(
                                  width: 200,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: TextEditingController(text: descriptioncodeKEY),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "ID",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 1.5, color: Colors.red),
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Row(
                                children: [
                                  // Container(
                                  //   width: 30,
                                  //   height: 30,
                                  //   child: IconButton(
                                  //     onPressed: () {},
                                  //     icon: Icon(Icons.remove),
                                  //     color: Colors.redAccent,
                                  //   ),
                                  // ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      controller: TextEditingController(text: quantity),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "quantity",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(width: 1.5, color: Colors.red),
                                            borderRadius: BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )),
                              DataCell(Row(
                                children: [
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      controller: TextEditingController(text: pricecodeKEY),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Price",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(width: 1.5, color: Colors.red),
                                            borderRadius: BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              DataCell(Row(
                                children: [
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      controller: _valueController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Value",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(width: 1.5, color: Colors.red),
                                            borderRadius: BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              // DataCell(IconButton(
                              //     onPressed: () {
                              //       datarows.remove(datarows.length);
                              //     },
                              //     icon: const Icon(
                              //       Icons.delete,
                              //     )))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Add Row'))
            ],
          ),
        ),
      ),
    );
  }

  // api call for the dropdown list
  Future<List<ProductCode>> productC() async {
    // methode to decode json data
    final response = await http.get(Uri.parse('http://192.168.1.38:8081/erp/api/product'));

    // response.body is String
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List; //converted to dynamic list
      List<ProductCode> prCodetype = data.map((e) => ProductCode.fromJson(e)).toList();
      debugPrint(
          '+++++++${data.runtimeType}++++${prCodetype[0].code}++++${prCodetype[0].description}++++${prCodetype[0].price}');

      debugPrint('+++++++${response.statusCode}++');
      return prCodetype;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class ProductCode {
  String? code;
  String? description;
  String? price;

  ProductCode({
    this.code,
    this.description,
    this.price,
  });

  factory ProductCode.fromJson(Map<String, dynamic> json) => ProductCode(
        code: json["code"],
        description: json["description"],
        price: json["price"],
      );
}

// "description": "REFLECTOR BRACKET",
//         "price": "115.00
