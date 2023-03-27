import 'package:flutter/material.dart';

class SellProduct extends StatefulWidget {
  const SellProduct({super.key});

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  DateTime date = DateTime.now();
  TextEditingController tc = TextEditingController();
  int availableDate = 0;
  int availableDate2 = 0;

  DateTime date1 = DateTime.now();
  TextEditingController tc1 = TextEditingController();

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
  //final today = DateUtils.dateOnly(DateTime.now());
  String? selectedSubType = 'गहू';
  String? selectedMainType = 'पीक';
  String? selectedSellDate = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "विक्री",
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
                    "विक्री कालावधी ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: tc,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "पासून ",
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
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (newDate == null) return;

                        setState(() {
                          availableDate = newDate.millisecondsSinceEpoch;
                          tc.text =
                              '${newDate.year}/${newDate.month}/${newDate.day}';
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: tc1,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "पर्यंत ",
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
                        DateTime? newDate1 = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (newDate1 == null) return;

                         setState(() {
                          availableDate2 = newDate1.millisecondsSinceEpoch;
                          tc1.text =
                              '${newDate1.year}/${newDate1.month}/${newDate1.day}';
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
                    "विक्री परिसर",
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
                      secondary: const Icon(Icons.holiday_village),
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
                      secondary: const Icon(Icons.location_city_rounded),
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
                      secondary: const Icon(Icons.location_city),
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
                      secondary: const Icon(Icons.area_chart_rounded),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          minimumSize: Size(40, 50) // Background color
                          ),
                      child: Text("नोंद करा"))
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

