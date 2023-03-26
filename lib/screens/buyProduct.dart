import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class BuyProduct extends StatefulWidget {
  const BuyProduct({super.key});

  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  DateTime date = DateTime.now();
  int available = 0;
  TextEditingController tc = TextEditingController();
  /*bool _valueVillage = true;
  bool _valueTaluka = false;
  bool _valueDistrict = false;
  bool _valueState = false;*/

  String? _valueLevel = "गाव पातळी";
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

  String? selectedSubType = 'गहू';
  String? selectedMainType = 'पीक';
  String? selectedBuyDate = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
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
        padding: const EdgeInsets.all(25.0),
        child: Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Row(
                children: [
                  const Text(
                    'मुख्य प्रकार',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
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
                                  value: e,
                                  child: Text(e),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'उप प्रकार',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
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
                                  value: e,
                                  child: Text(e),
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
                    width: 25,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: tc,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "तारीख निवडा",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
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
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (newDate == null) return;

                        setState(() {
                          available = newDate.millisecondsSinceEpoch;
                          tc.text =
                              '${newDate.year}/${newDate.month}/${newDate.day}';
                        });
                      },
                    ),
                  )
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
                    child: RadioListTile(
                      value: "गाव पातळी",
                      title: const Text("गाव पातळी"),
                      activeColor: Colors.green,
                      groupValue: _valueLevel,
                      onChanged: (String? value) {
                        setState(() => _valueLevel = value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: "तालुका पातळी",
                      title: const Text("तालुका पातळी"),
                      activeColor: Colors.green,
                      groupValue: _valueLevel,
                      onChanged: (String? value) {
                        setState(() => _valueLevel = value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: "जिल्हा पातळी",
                      title: const Text("जिल्हा पातळी"),
                      activeColor: Colors.green,
                      groupValue: _valueLevel,
                      onChanged: (String? value) {
                        setState(() => _valueLevel = value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: "राज्य पातळी",
                      title: const Text("राज्य पातळी"),
                      activeColor: Colors.green,
                      groupValue: _valueLevel,
                      onChanged: (String? value) {
                        setState(() => _valueLevel = value!);
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
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/checkProduct', (route) => false);
                      },
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
