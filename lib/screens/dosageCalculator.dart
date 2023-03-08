import 'package:dharati/services/FirebaseAllServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DosageCalculation extends StatefulWidget {
  const DosageCalculation({super.key});

  @override
  State<DosageCalculation> createState() => _DosageCalculationState();
}

class _DosageCalculationState extends State<DosageCalculation> {
  TextStyle labelTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.green.shade600,
  );
  TextStyle tableColumnTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.green.shade900,
  );

  TextStyle tableDataTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  TextStyle tableDataHeadTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.green.shade700,
  );

  final _gunthas = [
    "0",
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

  final crops = ["Sugarcane"];

  final doseType = ["Clear", "10:26:26", "DAP"];

  String? selectedGuntha = "0";

  String? selectedCrop = "Sugarcane";

  String? selectedDoseType = "Clear";

  int guntha = 0;

  String urea = "0.00";
  String ssp = "0.00";
  String mop = "0.00";
  String npk = "0.00";
  String dap = "0.00";
  String magnessium = "0.00";
  String silicon = "0.00";
  String sulphur = "0.00";
  String calcium = "0.00";
  String microNeutrient = "0.00";
  String humic = "0.00";
  String nimboli = "0.00";

  @override
  void initState() {
    clearAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
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
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 15),
            onPressed: () async {
              await FirebaseAllServices.instance.logOut();
              Get.offNamedUntil("/phone", (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Area",
                      style: labelTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Guntha",
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.green.shade900,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Colors.green.shade300, width: 1),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        menuMaxHeight: 250,
                        value: selectedGuntha,
                        validator: (value) =>
                            value == "0" ? "Please Select Guntha" : null,
                        items: _gunthas
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          selectedGuntha = value;
                          guntha = int.tryParse(value.toString()) ?? 0;
                          selectFertlizer(selectedDoseType!);
                        }),
                        onSaved: (newValue) => setState(() {
                          selectedGuntha = newValue;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Crop",
                      style: labelTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Colors.green.shade300, width: 1),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        menuMaxHeight: 250,
                        value: selectedCrop,
                        validator: (value) =>
                            value == null ? "Please Select Crop" : null,
                        items: crops
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          selectedCrop = value;
                        }),
                        onSaved: (newValue) => setState(() {
                          selectedCrop = newValue;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Dose Type",
                      style: labelTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: Colors.green.shade300, width: 1),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        menuMaxHeight: 250,
                        value: selectedDoseType,
                        validator: (value) =>
                            value == null ? "Please Select Dose Type" : null,
                        items: doseType
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          selectedDoseType = value;
                          selectFertlizer(selectedDoseType!);
                        }),
                        onSaved: (newValue) => setState(() {
                          selectedDoseType = newValue;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 3,
                color: Colors.green.shade700,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade700, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: FittedBox(
                    child: DataTable(
                      dataRowHeight: 80,
                      columns: [
                        DataColumn(
                          label:
                              Text("Fertilizer", style: tableColumnTextStyle),
                        ),
                        DataColumn(
                            label: Text(
                                selectedDoseType == null
                                    ? "-"
                                    : selectedDoseType.toString() + " (K.G.)",
                                style: tableColumnTextStyle),
                            numeric: true),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("Urea", style: tableDataHeadTextStyle)),
                          DataCell(Text(urea, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("SSP\n(Super Single Phosphate)",
                              style: tableDataHeadTextStyle)),
                          DataCell(Text(ssp, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("MOP (Potash)",
                              style: tableDataHeadTextStyle)),
                          DataCell(Text(mop, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(
                              Text("10:26:26", style: tableDataHeadTextStyle)),
                          DataCell(Text(npk, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("DAP", style: tableDataHeadTextStyle)),
                          DataCell(Text(dap, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("Magnessium",
                              style: tableDataHeadTextStyle)),
                          DataCell(Text(magnessium, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(
                              Text("Silicon", style: tableDataHeadTextStyle)),
                          DataCell(Text(silicon, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(
                              Text("Sulphur", style: tableDataHeadTextStyle)),
                          DataCell(Text(sulphur, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("Calcium / \nCalcium Nitrate",
                              style: tableDataHeadTextStyle)),
                          DataCell(Text(calcium, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("Micro Nutrient",
                              style: tableDataHeadTextStyle)),
                          DataCell(
                              Text(microNeutrient, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(
                              Text("Humic", style: tableDataHeadTextStyle)),
                          DataCell(Text(humic, style: tableDataTextStyle)),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("Organic / Nimboli",
                              style: tableDataHeadTextStyle)),
                          DataCell(Text(nimboli, style: tableDataTextStyle)),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearFertilizers() {
    setState(() {
      urea = ((guntha / 40) * 45).toStringAsFixed(2);
      ssp = ((guntha / 40) * 200).toStringAsFixed(2);
      mop = ((guntha / 40) * 50).toStringAsFixed(2);
      npk = ((guntha / 40) * 0).toStringAsFixed(2);
      dap = ((guntha / 40) * 0).toStringAsFixed(2);
      magnessium = ((guntha / 40) * 25).toStringAsFixed(2);
      silicon = ((guntha / 40) * 10).toStringAsFixed(2);
      sulphur = ((guntha / 40) * 10).toStringAsFixed(2);
      calcium = ((guntha / 40) * 10).toStringAsFixed(2);
      microNeutrient = ((guntha / 40) * 10).toStringAsFixed(2);
      humic = ((guntha / 40) * 15).toStringAsFixed(2);
      nimboli = ((guntha / 40) * 100).toStringAsFixed(2);
    });
  }

  void npkFertilizers() {
    setState(() {
      urea = ((guntha / 40) * 45).toStringAsFixed(2);
      ssp = ((guntha / 40) * 0).toStringAsFixed(2);
      mop = ((guntha / 40) * 0).toStringAsFixed(2);
      npk = ((guntha / 40) * 150).toStringAsFixed(2);
      dap = ((guntha / 40) * 0).toStringAsFixed(2);
      magnessium = ((guntha / 40) * 25).toStringAsFixed(2);
      silicon = ((guntha / 40) * 10).toStringAsFixed(2);
      sulphur = ((guntha / 40) * 10).toStringAsFixed(2);
      calcium = ((guntha / 40) * 10).toStringAsFixed(2);
      microNeutrient = ((guntha / 40) * 10).toStringAsFixed(2);
      humic = ((guntha / 40) * 15).toStringAsFixed(2);
      nimboli = ((guntha / 40) * 100).toStringAsFixed(2);
    });
  }

  void dapFertilizers() {
    setState(() {
      urea = ((guntha / 40) * 0).toStringAsFixed(2);
      ssp = ((guntha / 40) * 0).toStringAsFixed(2);
      mop = ((guntha / 40) * 50).toStringAsFixed(2);
      npk = ((guntha / 40) * 120).toStringAsFixed(2);
      dap = ((guntha / 40) * 0).toStringAsFixed(2);
      magnessium = ((guntha / 40) * 25).toStringAsFixed(2);
      silicon = ((guntha / 40) * 10).toStringAsFixed(2);
      sulphur = ((guntha / 40) * 10).toStringAsFixed(2);
      calcium = ((guntha / 40) * 10).toStringAsFixed(2);
      microNeutrient = ((guntha / 40) * 10).toStringAsFixed(2);
      humic = ((guntha / 40) * 15).toStringAsFixed(2);
      nimboli = ((guntha / 40) * 100).toStringAsFixed(2);
    });
  }

  void clearAll() {
    setState(() {
      urea = urea == "0.00" ? "-" : urea;
      ssp = ssp == "0.00" ? "-" : ssp;
      mop = mop == "0.00" ? "-" : mop;
      npk = npk == "0.00" ? "-" : npk;
      dap = dap == "0.00" ? "-" : dap;
      magnessium = magnessium == "0.00" ? "-" : magnessium;
      silicon = silicon == "0.00" ? "-" : silicon;
      sulphur = sulphur == "0.00" ? "-" : sulphur;
      calcium = calcium == "0.00" ? "-" : calcium;
      microNeutrient = microNeutrient == "0.00" ? "-" : microNeutrient;
      humic = humic == "0.00" ? "-" : humic;
      nimboli = nimboli == "0.00" ? "-" : nimboli;
    });
  }

  void selectFertlizer(String doseType) {
    if (doseType == "Clear") {
      clearFertilizers();
    } else if (doseType == "10:26:26") {
      npkFertilizers();
    } else if (doseType == "DAP") {
      dapFertilizers();
    }
    clearAll();
  }
}
