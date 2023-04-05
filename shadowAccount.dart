import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShadowAccount extends StatefulWidget {
  const ShadowAccount({super.key});

  @override
  State<ShadowAccount> createState() => _ShadowAccountState();
}

class _ShadowAccountState extends State<ShadowAccount> {
  var checkBox1 = false;
  String accountScheduleId = '362e3e395f0946bd800674f908538c60';
  String accountId = '';
  String accountName = '';
  var doubleWidth,doubleHeight,size;

  late List<ShadowAccounts> shadowAccountList;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchShadowAccountList();
      shadowAccountList;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    doubleHeight = size.height;
    doubleWidth = size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
            //padding: const EdgeInsets.only(top: 10),

            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      color: const Color.fromARGB(86, 236, 236, 236),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Create Shadow Account",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Radio button 1 customers
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
                            value: '362e3e395f0946bd800674f908538c60',
                            groupValue: accountScheduleId,
                            onChanged: (value) {
                              setState(
                                () {
                                  accountScheduleId =
                                      '362e3e395f0946bd800674f908538c60';
                                  debugPrint(accountScheduleId);
                                  shadowAccountList;
                                  fetchShadowAccountList();
                                },
                              );
                            },
                          ),
                          const Text('Customers'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    // Radio button 2 Suppliers
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
                            value: '1d238cd0926f4913a3b8d631e0dbe070',
                            groupValue: accountScheduleId,
                            onChanged: (value) {
                              setState(
                                () {
                                  accountScheduleId =
                                      '1d238cd0926f4913a3b8d631e0dbe070';
                                  debugPrint(accountScheduleId);
                                  shadowAccountList;
                                  fetchShadowAccountList();
                                },
                              );
                            },
                          ),
                          const Text('Suppliers'),
                        ],
                      ),
                    ),
                  ],
                ),

                // datatable to display list of ac_account
                SizedBox(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Accounts Name')),
                      DataColumn(label: Text('Select'))
                    ],
                    rows: shadowAccountList
                        .map(
                          (user) => DataRow(
                            cells: [
                              DataCell(onTap: () {
                                
                              },
                                Text(
                                  user.name.toString(),
                                ),
                              ),
                              DataCell(
                                FormField(
                                  builder: (state) {
                                    return Column(
                                      children: [
                                        Checkbox(
                                          splashRadius: 10.0,
                                          value: checkBox1,
                                          onChanged: (value) {
                                            checkBox1 = value!;
                                            state.didChange(value);
                                            if (checkBox1 == true) {
                                              accountName =
                                                  user.name.toString();
                                              accountId = user.id.toString();
                                              debugPrint(
                                                  'accountId = $accountId');
                                              debugPrint(
                                                  'accountName = $accountName');
                                            } else {
                                              debugPrint(
                                                  'please select account name..');
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ]),
      ),
      // floating button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (checkBox1 == true) {
            postIntoAdvAccData(accountId);
            showSuccessAlert();
          } else {
            showErrorAlert();
            debugPrint('Select account name..');
          }
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ShadowAccount(),
            ),
          );
        },
        label: const Text('Create shadow account'),
      ),
    );
  }

// api call to get the list of customers or suppliers
  Future<List<ShadowAccounts>> fetchShadowAccountList() async {
    // methode to decode json data
    shadowAccountList = [];
    var url =
        'http://192.168.1.38:8081/erp/api/account?accountScheduleId=$accountScheduleId';
    debugPrint('.....%%%.......$url');

    final response = await http.get(Uri.parse(url));

    // response.body is String
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List; //converted to dynamic list
      List<ShadowAccounts> accountList =
          data.map((e) => ShadowAccounts.fromJson(e)).toList();

      int listIndex = 0;
      debugPrint('+++++++${response.statusCode}++');
      for (final row in accountList) {
        setState(() {
          shadowAccountList.add(ShadowAccounts(
            id: row.id,
            name: row.name,
          ));
        });
        listIndex = listIndex + 1;
      }

      return accountList;
    } else {
      throw Exception('Failed to load album');
    }
  }

  // api call to create shadow account

  Future postIntoAdvAccData(String accountId) async {
    debugPrint("$accountId ,.........................this the data.");
    try {
      var url = Uri.parse(
        "http://192.168.1.38:8081/erp/api/adv-account",
      );
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'account_id': accountId,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('${response.body}..............');

        return response.body;
      } else {
        debugPrint(response.statusCode.toString());
        debugPrint("respond...body check......//");
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// Alert DailogBox for success
  void showSuccessAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Container(
          padding: const EdgeInsets.all(20),
          height: 90,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 73, 135, 64),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                accountName,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Shadow account created successfully !',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  // void text() {
  //   if (accountScheduleId == '402881eb553953350155395adf1f0004') {
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Customer: $accountName',
  //           style: const TextStyle(
  //               color: Colors.white, fontWeight: FontWeight.bold),
  //         ),
  //         const Text(
  //           'Shadow account created successfully !',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ],
  //     );
  //   } else {
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Supplier: $accountName',
  //           style: const TextStyle(
  //               color: Colors.white, fontWeight: FontWeight.bold),
  //         ),
  //         const Text(
  //           'Shadow account created successfully !',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ],
  //     );
  //   }
  // }

// Alert DailogBox for error
  void showErrorAlert() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Container(
          padding: const EdgeInsets.all(20),
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFFC72C41),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Oh snap !',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Please Select account name..',
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class ShadowAccounts {
  String? id;
  String? name;

  ShadowAccounts({
    this.id,
    this.name,
  });

  factory ShadowAccounts.fromJson(Map<String, dynamic> json) => ShadowAccounts(
        id: json["id"],
        name: json["name"],
      );
}

// QuickAlert.show(
//   context: context,
//   title: accountName,
//   text: "Shadow account created successfully !",
//   type: QuickAlertType.success,
//   onConfirmBtnTap: () {
//     setState(
//       () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ShadowAccount(),
//           ),
//         );
//       },
//     );
//   },
//   //autoCloseDuration: const Duration(seconds: 4),
// );
