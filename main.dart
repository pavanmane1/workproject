import 'package:flutter/material.dart';
import 'package:myapp/Auditoutwordsupply/demo.dart';
import 'package:myapp/bloCProject/demoblocui.dart';
import 'package:myapp/Auditoutwordsupply/auditoutwordsupply.dart';
import 'package:myapp/mastertableui.dart';
import 'package:myapp/purchaseorder/Potabletable.dart';
import 'package:myapp/purchaseorder/pdfreport.dart';
import 'package:myapp/purchaseorder/purchaseorder.dart';
import 'package:myapp/salesorder.dart';

void main() {
  runApp(MyHomePage());
}

/* void main() {
  runApp(const MyHomePage());
} */

/* class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedValue;
  List<ArrayList> array = [
    ArrayList(id: "1", name: "male"),
    ArrayList(id: "2", name: "female"),
    ArrayList(id: "3", name: "other")
  ];
  @override
  Widget build(BuildContext context) {
    // final array = [
    //   {
    //     {"M": "male"},
    //     {"F": "female"},
    //     {"O": "other"}
    //   }
    // ];
    //final array = ['male','female','other'];
    // array.add()
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Dropdowns(
          array: array,
          defaultValueIndex: 2,
          onChanged: (String newValue) {
            setState(() {
              selectedValue = newValue;
            });
            print("Value selected: $newValue");
          },
        )),
      ),
    );
  }
} */

/* class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('DateFilter'),
          ),
          body: const Datefilter()),
    );
  }
} */

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Secondclass(),
    );
  }
}

class Secondclass extends StatelessWidget {
  const Secondclass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Auditoutwordsupply());
  }
}

/* import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(MyApp());
} */
/*  Center(
                  child: Container(
                    width: 500,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Country code :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 230,
                                child: TextFormField(
                                  controller: _codeController,
                                  onTap: () async {
                                    setState(() {});
                                  },
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintStyle: const TextStyle(fontSize: 15),
                                  ),
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
                              const SizedBox(
                                width: 60,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Name :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 230,
                              child: TextFormField(
                                controller: _nameController,
                                onTap: () async {
                                  setState(() {});
                                },
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintStyle: const TextStyle(fontSize: 15),
                                ),
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
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {
                                    CountrycodeapiCall();
                                    setState(() {
                                      tableData = _countrydata;
                                      bool isbuttoncountrypressed = true;
                                      bool isbuttoncurrancypressed = false;
                                    });
                                  },
                                  child: Text("show")),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    width: 500,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Currency code:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 230,
                                child: TextFormField(
                                  controller: _codeController,
                                  onTap: () async {
                                    setState(() {});
                                  },
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintStyle: const TextStyle(fontSize: 15),
                                  ),
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
                              const SizedBox(
                                width: 50,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Name :',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 230,
                              child: TextFormField(
                                controller: _nameController,
                                onTap: () async {
                                  setState(() {});
                                },
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintStyle: const TextStyle(fontSize: 15),
                                ),
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
                            Container(
                              child: ElevatedButton(
                                  onPressed: () {
                                    countryStateapicall();
                                    setState(() {
                                      bool isbuttoncountrypressed = false;
                                      bool isbuttoncurrancypressed = true;
                                      tableData = _currancydata;
                                    });
                                  },
                                  child: Text("show")),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ), */
class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  int _selectedRow = -1;

  void _onEditClicked(int row) {
    setState(() {
      _selectedRow = row;
    });
  }

  void _onDeleteClicked(int row) {
    // Implement delete logic here
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Edit',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Delete',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
      rows: List<DataRow>.generate(
        // Generate rows with edit and delete buttons
        10,
        (index) => DataRow(
          cells: [
            DataCell(
              GestureDetector(
                onTap: () {
                  _onEditClicked(index);
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: _selectedRow == index ? Colors.blue : Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () {
                  _onDeleteClicked(index);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: _selectedRow == index ? Colors.blue : Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
