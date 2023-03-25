import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class BuyProduct extends StatefulWidget {
  const BuyProduct({super.key});

  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  DateTime date = DateTime(2023, 03, 25);
  bool _valueVillage = false;
  bool _valueTaluka = false;
  bool _valueDistrict = false;
  bool _valueState = false;
  final mainCropType = ['पीक', 'भाजी', 'पशुधन'];
  var availableSubCropType = [];
  final subCropType1 = [
    'गहू',
    'ज्वारी',
    'तांदूळ',
    'मका',
    'नाचणी',
    'भुईमूग',
    'सोयाबीन',
  ];
  final subCropType2 = [
    'मेथी',
    'पोकळा',
    'करडई',
    'पालक',
    'कांदा',
    'टोमॅटो',
    'बटाटा',
    'दोडका',
    'शेवगा',
    'पावटा',
    'गवारी',
    'वांगी',
    'काकडी',
    'गाजर',
    'मुळा',
    'कोथिंबीर',
    'आले',
    'लसूण',
    'कारले'
  ];
  final subCropType3 = ['गाई', 'म्हशी', 'शेळ्या', 'डुकरे'];
  //final today = DateUtils.dateOnly(DateTime.now());
  String? selectedSubType = 'गहू';
  String? selectedMainType = 'पीक';
  String? selectedBuyDate = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "खरेदी",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(25.0),
        child: Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Row(
                children: [
                  Text(
                    'मुख्य प्रकार',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "मुख्य प्रकार",
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
                        value: selectedMainType,
                        validator: (value) =>
                            value == "0" ? "कृपया मुख्य प्रकार निवडा" : null,
                        items: mainCropType
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          selectedSubType = null;
                          availableSubCropType.clear();
                          selectedMainType = value;
                          fetchSubCropType(selectedMainType);
                        }),
                        onSaved: (newValue) => setState(() {
                          selectedMainType = newValue;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'उप प्रकार',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "उप प्रकार",
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
                        value: selectedSubType,
                        validator: (value) =>
                            value == "0" ? "कृपया उप प्रकार निवडा" : null,
                        items: availableSubCropType
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          selectedSubType = value as String?;
                        }),
                        onSaved: (newValue) => setState(() {
                          selectedSubType = newValue as String?;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "खरेदी दिवस",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    '${date.year}/${date.month}/${date.day}',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    tooltip: 'Select Buy Date',
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (newDate == null) return;

                      setState(() => date = newDate);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "खरेदी परिसर",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      value: _valueVillage,
                      selected: _valueVillage,
                      title: const Text("गाव पातळी"),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      secondary: const Icon(Icons.holiday_village),
                      onChanged: (bool? value) {
                        setState(() => _valueVillage = value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      value: _valueTaluka,
                      selected: _valueTaluka,
                      title: const Text("तालुका पातळी"),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      secondary: const Icon(Icons.holiday_village),
                      onChanged: (bool? value) {
                        setState(() => _valueTaluka = value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      value: _valueDistrict,
                      selected: _valueDistrict,
                      title: const Text("जिल्हा पातळी"),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      secondary: const Icon(Icons.holiday_village),
                      onChanged: (bool? value) {
                        setState(() => _valueDistrict = value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      value: _valueState,
                      selected: _valueState,
                      title: const Text("राज्य पातळी"),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      secondary: const Icon(Icons.holiday_village),
                      onChanged: (bool? value) {
                        setState(() => _valueState = value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          minimumSize: Size(40, 50) // Background color
                          ),
                      child: Text("पर्याय पहा"))
                ],
              )
            ])),
      )),
    );
  }

  fetchSubCropType(String? mainCrop) {
    setState(() {
      if (mainCrop == 'पीक') {
        availableSubCropType = subCropType1;
      } else if (mainCrop == 'भाजी') {
        availableSubCropType = subCropType2;
      } else if (mainCrop == 'पशुधन') {
        availableSubCropType = subCropType3;
      }
    });
  }
}
