import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: OditoutwordsupplyGetApi('2022-04-01', '2023-03-31', 'S03'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> data = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
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
                  rows: data
                      .map((item) => DataRow(cells: [
                            DataCell(
                              Text(item['product_code'].toString()),
                            ),
                            DataCell(
                              Text(item['product_description'].toString()),
                            ),
                            DataCell(
                              Text(item['quantity'].toString()),
                            ),
                            DataCell(
                              Text(item['uom_code'].toString()),
                            ),
                            DataCell(
                              Text(item['rate'].toString()),
                            ),
                            DataCell(
                              Text(item['taxable'].toString()),
                            ),
                            DataCell(
                              Text(item['cgst_amount'].toString()),
                            ),
                            DataCell(
                              Text(item['item_value'].toString()),
                            ),
                          ]))
                      .toList(),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Failed to load data');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> OditoutwordsupplyGetApi(
      String fromDate, String toDate, String transactiontype) async {
    print(fromDate);
    print(toDate);
    print(transactiontype);
    final response =
        await http.get(Uri.parse('http://192.168.1.38:8081/erp/api/osdetail?pid=92259a14a9314c83b2218008c9ebd118'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      List<Map<String, dynamic>> suppliers = data.map((item) {
        return {
          'product_code': item['product_code'],
          'product_description': item['product_description'],
          'quantity': item['quantity'],
          'account_name': item['account_name'],
          'uom_code': item['uom_code'],
          'rate': item['rate'],
          'taxable': item['taxable'],
          'cgst_amount': item['cgst_amount'],
          'item_value': item['item_value'],
        };
      }).toList();

      return suppliers;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
