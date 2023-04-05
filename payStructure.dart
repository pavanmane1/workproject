import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PayStructure extends StatefulWidget {
  const PayStructure({super.key});

  @override
  State<PayStructure> createState() => _PayStructureState();
}

class _PayStructureState extends State<PayStructure> {
  var doubleWidth, doubleHeight, size;
  String dateofapplication = '';
  String employeeid = '';
  String employeeN = '';
  String empptypeCode = '';
  late Future<List<EmployeeName>> employeeName;

  double basicSalary = 0,
      da = 0,
      hra = 0,
      lta = 0,
      conveyance = 0,
      medicalAllowance = 0,
      specialAllowance = 0,
      lic = 0,
      pf = 0,
      pt = 0,
      esic = 0,
      totalDeduction = 0,
      netSalary = 0;

  double grossSalary = 0;

  addGrossSal() {
    grossSalary = double.parse(_basicSalaryController.text) +
        double.parse(_daController.text) +
        double.parse(_hraController.text) +
        double.parse(_ltaController.text) +
        double.parse(_conveyanceController.text) +
        double.parse(_medicalAllowanceController.text) +
        double.parse(_specialAllowanceController.text);

    _grossSalaryController.text = grossSalary.toString();
  }

  addTotDed() {
    totalDeduction = double.parse(_licController.text) +
        double.parse(_pfController.text) +
        double.parse(_ptController.text) +
        double.parse(_esicController.text);

    _totalDeductionController.text = totalDeduction.toString();
  }

  netSal() {
    netSalary = double.parse(_grossSalaryController.text) -
        double.parse(_totalDeductionController.text);

    _netSalaryController.text = netSalary.toString();
  }

  final _basicSalaryController = TextEditingController();
  final _daController = TextEditingController();
  final _hraController = TextEditingController();
  final _ltaController = TextEditingController();

  final _conveyanceController = TextEditingController();
  final _medicalAllowanceController = TextEditingController();
  final _specialAllowanceController = TextEditingController();
  final _grossSalaryController = TextEditingController();
  final _licController = TextEditingController();

  final _pfController = TextEditingController();
  final _ptController = TextEditingController();
  final _esicController = TextEditingController();
  final _totalDeductionController = TextEditingController();
  final _netSalaryController = TextEditingController();
  final _applicationDateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateofapplication = _applicationDateController.text;
    //basicSalary = _basicSalaryController.text;
    employeeName = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    int grossSalary;
    size = MediaQuery.of(context).size;
    doubleHeight = size.height;
    doubleWidth = size.width;
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
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
                    "Employee Pay Structure",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //Container1: Information
                Container(
                  width: doubleWidth / 1.1,
                  padding: const EdgeInsets.all(10),
                  //margin: EdgeInsets.only(bottom: ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      color: const Color.fromARGB(87, 182, 215, 242),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        "INFORMATION",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // ID TEXTFIELD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ID :",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            width: doubleWidth / 2.3,
                            height: 50,
                            child: TextFormField(
                              controller:
                                  TextEditingController(text: employeeid),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "ID",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1.5, color: Colors.red),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              //readOnly: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value != null && value.length < 1) {
                                  return '\u26A0 Enter valid igstcredit';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // Date of \napplication
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date of \napplication :',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 50,
                            width: doubleWidth / 2.3,
                            child: TextFormField(
                              onTap: () async {
                                setState(() {
                                  _fromDate(context);
                                });
                              },
                              controller: _applicationDateController,
                              readOnly: true,
                              onChanged: (value) {
                                debugPrint(_applicationDateController.text);
                                //_applicationDateController.text = value;
                              },
                              decoration: InputDecoration(
                                //hintText: dateofapplication,
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

                      // Name and paytype DROPDOWN
                      FutureBuilder<List<EmployeeName>>(
                        future: employeeName,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            return Center(
                              // heightFactor: 200.0,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Name :',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: doubleWidth / 2.3,
                                        child: DropdownSearch<EmployeeName>(
                                          popupProps: const PopupProps.menu(
                                              //showSearchBox: true,
                                              ),
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: "name",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          itemAsString: (EmployeeName item) =>
                                              item.name.toString(),
                                          items: snapshot.data!.toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              employeeN = val!.name.toString();
                                              employeeid =
                                                  val.employee_id.toString();
                                              empptypeCode =
                                                  val.paytype_code.toString();
                                            });

                                            debugPrint(
                                                '.....${employeeN.toString()}.....${employeeid.toString()}......${empptypeCode.toString()}');
                                          },
                                          validator: (val) => val == null
                                              ? '\u26A0 Pllease select code.'
                                              : null,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Paytype :',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: doubleWidth / 2.3,
                                        child: DropdownSearch(
                                          popupProps: const PopupProps.menu(
                                              fit: FlexFit.loose
                                              //showSearchBox: true,
                                              ),
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: "paytype",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          selectedItem: empptypeCode,
                                          items: [empptypeCode],
                                          onChanged: (val) {
                                            debugPrint(
                                                '...........${empptypeCode.toString()}');
                                          },
                                          validator: (val) => val == null
                                              ? '\u26A0 Pllease select code.'
                                              : null,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            //debugPrint('erroroccurs');
                            return const CircularProgressIndicator();
                          }
                        }),
                      ),

                      // Pay-Type DROPDOWN
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                //Container2: Basic Salary
                Card(
                  child: ExpansionTile(
                      title: const Text(
                        "BASIC SALARY",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Container(
                          width: doubleWidth / 1.1,
                          padding: const EdgeInsets.all(10),
                          //margin: EdgeInsets.all(10),

                          child: Column(
                            children: [
                              // BASIC Salary TEXTFIELD
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "BASIC Salary :",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      width: doubleWidth / 2.3,
                                      child: TextFormField(
                                        controller: _basicSalaryController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "basic salary",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1.5,
                                                  color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        // inputFormatters: [
                                        //   FilteringTextInputFormatter.allow(
                                        //       RegExp("[0-9]"))
                                        // ],
                                        onChanged: (value) {
                                          debugPrint(value);
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value != null &&
                                              value.length < 1) {
                                            return '\u26A0 Enter valid igstcredit';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 5,
                ),

                //Container3: Addition
                Card(
                  child: ExpansionTile(
                    title: const Text(
                      "ADDITION",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Container(
                        width: doubleWidth / 1.1,
                        padding: const EdgeInsets.all(10),
                        //margin: EdgeInsets.all(10),

                        child: Column(
                          children: [
                            //DA TEXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "DA :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _daController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "DA",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid DA';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //HRA TEXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "HRA:",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _hraController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "HRA",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid HRA';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //lta TEXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "LTA :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _ltaController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "LTA",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid LTA';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //Conveyance TEXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Conveyance :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _conveyanceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Conveyance",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid Conveyance';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //Medical Allowance TEXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Medical\nAllowance :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _medicalAllowanceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "MA",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid Medical Allowance';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //Special Allowance TEXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Special\nAllowance :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _specialAllowanceController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "SA",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid Special Allowance ';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //Gross Salary TEXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Gross Salary :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _grossSalaryController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          addGrossSal();
                                        });
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid Gross salary';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                //Container4: Deduction
                Card(
                  child: ExpansionTile(
                    title: const Text(
                      "DEDUCTION",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Container(
                        width: doubleWidth / 1.1,
                        padding: const EdgeInsets.all(10),
                        //margin: EdgeInsets.all(10),

                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            //LIC TXTFIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "LIC :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _licController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "LIC",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid LIC';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "PF:",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _pfController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "PF",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid PF';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "PT :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _ptController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {},
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid PT';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "ESIC :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      controller: _esicController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "ESIC",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onChanged: (value) {
                                        debugPrint(value);
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid ESIC';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total \nDeduction :",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: doubleWidth / 2.3,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: _totalDeductionController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1.5, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onTap: (() {
                                        setState(() {
                                          addTotDed();
                                        });
                                      }),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value != null && value.length < 1) {
                                          return '\u26A0 Enter valid TotalDuration';
                                        } else {
                                          return null;
                                        }
                                      },
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                //Container5: Net Salary
                Card(
                  child: ExpansionTile(
                      title: const Text(
                        "NET Salary",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Container(
                          width: doubleWidth / 1.1,
                          padding: const EdgeInsets.all(10),
                          //margin: EdgeInsets.all(10),

                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "NET Salary :",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      width: doubleWidth / 2.3,
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: _netSalaryController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "0",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1.5,
                                                  color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            netSal();
                                          });
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value != null &&
                                              value.length < 1) {
                                            return '\u26A0 Enter valid NET Salary';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                ),

                //Elevatedbuttons
                Container(
                  width: doubleWidth / 1.1,
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: () {
                      setState(() {
                        // postIntoPayStructData();
                      });
                    },
                    child: const Text('Save'),
                  ),
                ),

                //Elevatedbuttons
                Container(
                  width: doubleWidth / 1.1,
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text('Print'),
                  ),
                ),

                //Elevatedbuttons
                Container(
                  width: doubleWidth / 1.1,
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromARGB(158, 158, 158, 158)),
                    onPressed: () {},
                    child: const Text('Cancel'),
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
    final DateTime? fromPicked = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now().subtract(const Duration()),
        lastDate: DateTime(2100));

    if (fromPicked != null) {
      debugPrint(fromPicked.toString());
      setState(() {
        _applicationDateController.text =
            DateFormat('yyyy-MM-dd').format(fromPicked);
        dateofapplication = _applicationDateController.text;
      });
    } else {
      debugPrint('not selected..');
    }
  }

  Future postIntoPayStructData(
      String employeeid,
      String empptypeCode,
      String dateapplication,
      double basicSalary,
      double da,
      double hra,
      double lta,
      double conveyance,
      double medicalAllowance,
      double specialAllowance,
      double lic,
      double pf,
      double esic) async {
    // debugPrint(
    //     "$fiscal,$tranactiontype,$dateapplication, $dateofexpi,$isactiv, $maximumigstcredi.........................this the data.");
    try {
      var url = Uri.parse(
        "http://192.168.1.45:8081/erp/api/igstonexport/",
      );
      final response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'employee_id': employeeid,
          'dateofapplication': dateapplication,
          'paytype_code': empptypeCode,
          'basicpay': basicSalary,
          'dearnessallowance': da,
          'houserentallowance': hra,
          'travellingallowance': lta,
          'conveyanceallowance': conveyance,
          'medicalallowance': medicalAllowance,
          'otheraddition1': specialAllowance,
          'lifeinsurancepremium': lic,
          'providentfund': pf,
          'esic_rate': esic,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('${response.body}..............');

        return response.body;
      } else {
        // debugPrint(response.statusCode.toString());
        //   debugPrint("respond...boday check......//");
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

// fetch JSON data for employee name list
Future<List<EmployeeName>> fetchAlbum() async {
  // methode to decode json data
  final response =
      await http.get(Uri.parse('http://192.168.1.38:8081/erp/api/employee'));

  // response.body is String
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body) as List; //converted to dynamic list
    List<EmployeeName> empName =
        data.map((e) => EmployeeName.fromJson(e)).toList();
    debugPrint('+++++++${data.runtimeType}++++${empName[0].name}++');
    debugPrint('+++++++${data.runtimeType}++++${empName[0].employee_id}++');
    debugPrint('+++++++${data.runtimeType}++++${empName[0].paytype_code}++');

    debugPrint('+++++++${response.statusCode}++');
    return empName;
  } else {
    throw Exception('Failed to load name');
  }
}

class EmployeeName {
  int? employee_id;
  String? name;
  String? paytype_code;

  EmployeeName({
    this.employee_id,
    this.name,
    this.paytype_code,
  });

  factory EmployeeName.fromJson(Map<String, dynamic> json) => EmployeeName(
        employee_id: json["employee_id"],
        name: json["name"],
        paytype_code: json["paytype_code"],
      );
}
