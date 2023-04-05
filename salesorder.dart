import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SalesOrder extends StatefulWidget {
  @override
  _SalesOrderState createState() => _SalesOrderState();
}

class _SalesOrderState extends State<SalesOrder> {
  late Future<List<ProductCode>> productDeatils;
  List<DataRow> dataRows = [];
  late TextEditingController _discriptionController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late TextEditingController _valueController;
  String productcodeKEY = '';
  String descriptioncodeKEY = '';
  String pricecodeKEY = '';
  String Quantity = '';
  String Price = '';
  var totalPrice;
  final List<String> totoaladdquantity = <String>[];
  final List<String> totoaladdprices = <String>[];
  final List<String> totoalValue = <String>[];

  List<ProductCode> productCodes = [];
  @override
  void initState() {
    super.initState();
    productDeatils = productApi();
    _discriptionController = TextEditingController(text: "");
    _quantityController = TextEditingController(text: "");
    _priceController = TextEditingController(text: "");
    _valueController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            ],
            rows: dataRows,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text("Add Row"),
            onPressed: () {
              setState(() {
                _discriptionController = TextEditingController();
                _priceController = TextEditingController();
                _valueController = TextEditingController();
                dataRows.add(
                  DataRow(
                    cells: [
                      const DataCell(Text('*')),
                      DataCell(
                        SizedBox(
                          width: 250,
                          height: 120,
                          child: FutureBuilder<List<ProductCode>>(
                              future: productDeatils,
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
                                        descriptioncodeKEY = val.description.toString();
                                        _discriptionController.text = descriptioncodeKEY;
                                        pricecodeKEY = val.price.toString();
                                        _priceController.text = pricecodeKEY;
                                        Price = _priceController.text;
                                        totoaladdprices.add(Price);
                                        print(" prices  $totoaladdprices");
                                        // loop through each DataRow and update the corresponding controllers if necessary
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
                      DataCell(TextField(
                          controller: _discriptionController,
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1.0, color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Discription"))),
                      DataCell(TextField(
                          onChanged: (String value) {
                            Quantity = value;
                            setState(() {
                              totalPrice = double.parse(Quantity) * double.parse(Price);
                              _valueController.text = totalPrice.toString();
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1.0, color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Quantity"))),
                      DataCell(TextField(
                          onChanged: (String value) {
                            Price = value;
                          },
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1.0, color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Price"))),
                      DataCell(TextField(
                          controller: _valueController,
                          onChanged: (String value) {},
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1.0, color: Colors.red),
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Value"))),
                    ],
                  ),
                );
                totoaladdquantity.add(Quantity);
                // totoaladdprices.add(Price);
                totoalValue.add(totalPrice.toString());
                print("total Values $totoalValue");
                print("total Quantity $totoaladdquantity");
              });
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text("Save"),
            onPressed: () {
              print('Input value: $Quantity');
              print('Input value: $Price');
              print('Input value: $totoalValue');
            },
          ),
        ],
      ),
    );
  }

  Future<List<ProductCode>> productApi() async {
    // methode to decode json data
    final response = await http.get(Uri.parse('http://192.168.1.38:8081/erp/api/product'));

    // response.body is String
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List; //converted to dynamic list
      List<ProductCode> productdetails = data.map((e) => ProductCode.fromJson(e)).toList();
      debugPrint(
          '+++++++${data.runtimeType}++++${productdetails[0].code}++++${productdetails[0].description}++++${productdetails[0].price}');

      debugPrint('+++++++${response.statusCode}++');
      return productdetails;
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
