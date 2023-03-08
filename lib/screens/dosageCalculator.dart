import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DosageCalculator extends StatefulWidget {
  const DosageCalculator({super.key});

  @override
  State<DosageCalculator> createState() => _DosageCalculatorState();
}

class _DosageCalculatorState extends State<DosageCalculator> {
  final _formKey = GlobalKey<FormState>();
  final area = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40"
  ];
  String? selectedArea = "1";

  final Crop = ["Sugarcane"];
  String? selectedCrop = "Sugarcane";

  final doseType = ["Clear(KG)", "10:26:26(KG)", "DAP(KG)"];
  String? selectedDoseType = "Clear(KG)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Dosage Calculator",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "Area",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.green.shade900,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 73, 206, 78), width: 2),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 250,
                    hint: Text("Select Area"),
                    value: selectedArea,
                    items: area
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedArea = value;
                    }),
                    onSaved: ((newValue) => setState(() {
                          selectedArea = newValue;
                        })),
                    validator: (value) =>
                        value == null ? "Please Select area" : null,
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "Crop",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.green.shade900,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 73, 206, 78), width: 2),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 250,
                    hint: Text("Select Crop"),
                    value: selectedCrop,
                    items: Crop.map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        )).toList(),
                    onChanged: (value) => setState(() {
                      selectedCrop = value;
                    }),
                    onSaved: ((newValue) => setState(() {
                          selectedCrop = newValue;
                        })),
                    validator: (value) =>
                        value == null ? "Please Select Crop" : null,
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "Dose Type",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.green.shade900,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 73, 206, 78), width: 2),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 250,
                    hint: Text("Select Dose Type"),
                    value: selectedDoseType,
                    items: doseType
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedDoseType = value;
                    }),
                    onSaved: ((newValue) => setState(() {
                          selectedDoseType = newValue;
                        })),
                    validator: (value) =>
                        value == null ? "Please Select Dose Type" : null,
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.green,
                          width: 2,
                          style: BorderStyle.solid)),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(150.0),
                    border: TableBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Fertilizer',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          )
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(selectedDoseType!,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('Urea'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('SSP(Super Single Phosphate)'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('MOP(Potash)'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('10:26:26'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('DAP'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Magnessium'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Silicon'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Sulpher'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Calcium / Calcium Nitrate'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Micro Nutrient'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Humic'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Organic / Nimboli'))
                        ]),
                        Column(children: [
                          Padding(
                              padding: EdgeInsets.all(8.0), child: Text('-'))
                        ]),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  //variables

