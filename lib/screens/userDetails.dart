import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharati/main.dart';
import 'package:dharati/screens/dosageCalculator.dart';
import 'package:dharati/services/FirebaseAllServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  //variables

  bool loading = true;
  bool get loadingSts => loading;
  final user = FirebaseAuth.instance.currentUser!;

  final _formKey = GlobalKey<FormState>();

  final _acres = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

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

  final mainCrops = ["Sugarcane"];

  final internalCrops = [
    "Groundnut",
    "Jowar",
    "Onion",
    "Soyabean",
    "Vegetables",
    "Wheat"
  ];

  final irrigationTypes = ["Drip", "Traditional"];

  final irrigationSources = ["Borewell", "River", "Well"];

  List<dynamic> allDistricts = [];
  List<dynamic> allTalukas = [];
  var availableTalukas = [];
  List<dynamic> allVillages = [];
  var availableVillages = [];

  String? selectedAcre = "0";
  String? selectedGuntha = "0";
  String? selectedMainCrop;
  String? selectedInternalCrop;
  String? selectedInrrigationType;
  String? selectedInrrigationSource;
  String? selectedDistrict;
  String? selectedTaluka;
  String? selectedVillage;

  @override
  void initState() {
    createDistList();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome to Dharati",
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
      body: loadingSts
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Total Agri Land",
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.green.shade500, width: 2)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Row(
                              children: [
                                ButtonTheme(
                                  alignedDropdown: true,
                                  child: Expanded(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        labelText: "Acre",
                                        labelStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.green.shade900,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Colors.green.shade300,
                                              width: 1),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      menuMaxHeight: 250,
                                      value: selectedAcre,
                                      validator: (value) => (value == "0" &&
                                              selectedGuntha == "0")
                                          ? "Please Select Acre"
                                          : null,
                                      items: _acres
                                          .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedAcre = value;
                                        });
                                      },
                                      onSaved: ((newValue) => setState(() {
                                            selectedAcre = newValue;
                                          })),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ButtonTheme(
                                  alignedDropdown: true,
                                  child: Expanded(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        labelText: "Guntha",
                                        floatingLabelAlignment:
                                            FloatingLabelAlignment.start,
                                        labelStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.green.shade900,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Colors.green.shade300,
                                              width: 1),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      menuMaxHeight: 250,
                                      value: selectedGuntha,
                                      validator: (value) =>
                                          (value == "0" && selectedAcre == "0")
                                              ? "Please Select Guntha"
                                              : null,
                                      items: _gunthas
                                          .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                          .toList(),
                                      onChanged: (value) => setState(() {
                                        selectedGuntha = value;
                                      }),
                                      onSaved: ((newValue) => setState(() {
                                            selectedGuntha = newValue;
                                          })),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Main Crop",
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
                                  color: Colors.green.shade500, width: 2),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 250,
                          isExpanded: true,
                          isDense: true,
                          hint: Text("Select Main Crop"),
                          value: selectedMainCrop,
                          items: mainCrops
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedMainCrop = value;
                          }),
                          onSaved: ((newValue) => setState(() {
                                selectedMainCrop = newValue;
                              })),
                          validator: (value) =>
                              value == null ? "Please Select Main Crop" : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Internal Crop",
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
                                  color: Colors.green.shade500, width: 2),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 250,
                          isExpanded: true,
                          isDense: true,
                          hint: Text("Select Internal Crop"),
                          value: selectedInternalCrop,
                          items: internalCrops
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedInternalCrop = value;
                          }),
                          onSaved: ((newValue) => setState(() {
                                selectedInternalCrop = newValue;
                              })),
                          validator: (value) => value == null
                              ? "Please Select Internal Crop"
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Irrigation Type",
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
                                  color: Colors.green.shade500, width: 2),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 250,
                          isExpanded: true,
                          isDense: true,
                          hint: Text("Select Irrigation Type"),
                          value: selectedInrrigationType,
                          items: irrigationTypes
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedInrrigationType = value;
                          }),
                          onSaved: ((newValue) => setState(() {
                                selectedInrrigationType = newValue;
                              })),
                          validator: (value) => value == null
                              ? "Please Select Irrigation Type"
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Irrigation Source",
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
                                  color: Colors.green.shade500, width: 2),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 250,
                          isExpanded: true,
                          isDense: true,
                          hint: Text("Select Irrigation Source"),
                          value: selectedInrrigationSource,
                          items: irrigationSources
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedInrrigationSource = value;
                          }),
                          onSaved: ((newValue) => setState(() {
                                selectedInrrigationSource = newValue;
                              })),
                          validator: (value) => value == null
                              ? "Please Select Irrigation Source"
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "District",
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
                                  color: Colors.green.shade500, width: 2),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 250,
                          isExpanded: true,
                          isDense: true,
                          hint: Text("Select District"),
                          value: selectedDistrict,
                          items: allDistricts
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e["label"]),
                                    value: e["id"],
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedTaluka = null;
                            selectedVillage = null;
                            availableTalukas.clear();
                            availableVillages.clear();
                            selectedDistrict = value;
                            fetchTalukas(selectedDistrict);
                          }),
                          onSaved: ((newValue) => setState(() {
                                selectedDistrict = newValue;
                              })),
                          validator: (value) =>
                              value == null ? "Please Select District" : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Taluka",
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
                                  color: Colors.green.shade500, width: 2),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 250,
                          isExpanded: true,
                          isDense: true,
                          hint: Text("Select Taluka"),
                          value: selectedTaluka,
                          items: availableTalukas
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e["label"]),
                                    value: e["id"],
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedVillage = null;
                            availableVillages.clear();
                            selectedTaluka = value;
                            fetchVillages(selectedTaluka);
                          }),
                          onSaved: ((newValue) => setState(() {
                                selectedTaluka = newValue;
                              })),
                          validator: (value) =>
                              value == null ? "Please Select Taluka" : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: "Village",
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
                                  color: Colors.green.shade500, width: 2),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 250,
                          isExpanded: true,
                          isDense: true,
                          hint: Text("Select Village"),
                          value: selectedVillage,
                          items: availableVillages
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e["label"]),
                                    value: e["id"],
                                  ))
                              .toList(),
                          onChanged: (value) => setState(() {
                            selectedVillage = value;
                          }),
                          onSaved: ((newValue) => setState(() {
                                selectedVillage = newValue;
                              })),
                          validator: (value) =>
                              value == null ? "Please Select Village" : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseAllServices.instance.addData(
                                  selectedAcre!,
                                  selectedGuntha!,
                                  selectedMainCrop!,
                                  selectedInternalCrop!,
                                  selectedInrrigationType!,
                                  selectedInrrigationSource!,
                                  selectedDistrict!,
                                  selectedTaluka!,
                                  selectedVillage!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DosageCalculator()),
                              );
                            } else {
                              Get.snackbar(
                                "Invalid Data",
                                "All Fields are Mandatory",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                margin: EdgeInsets.all(15),
                                forwardAnimationCurve: Curves.easeOutBack,
                                colorText: Colors.white,
                              );
                            }
                          },
                          child: Text(
                            'Update and Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> createDistList() async {
    /*final districtsURL = "https://jsonkeeper.com/b/Y44B";
    final talukasURL =
        "https://drive.google.com/file/d/1PayUcxOF9cf1Z8JYibIG4fBGdkv9XGf4/view?usp=share_link";
    final villagesURL =
        "https://drive.google.com/file/d/1Cs0L6eKeUG2UNugQ1H_ARRtCT5e_PRKU/view?usp=share_link";*/
    /*try {
      var jsonDistrictsData = await http.get(Uri.parse(districtsURL));
      if (jsonDistrictsData.statusCode == 200) {
        List<dynamic> districtsList =
            await json.decode(jsonDistrictsData.body) as List<dynamic>;
        setState(() {
          allDistricts = districtsList;
        });
        print("okay");
      }
    } catch (e) {
      print(e.toString());
    }*/
    final jsonDistrictsData =
        await rootBundle.loadString("assets/JSON Files/Districts.json");
    List<dynamic> districtsList =
        json.decode(jsonDistrictsData) as List<dynamic>;
    setState(() {
      allDistricts = districtsList;
    });
    final jsonTalukasData =
        await rootBundle.loadString("assets/JSON Files/Talukas.json");
    List<dynamic> talukasList =
        await json.decode(jsonTalukasData) as List<dynamic>;
    setState(() {
      allTalukas = talukasList;
    });
    final jsonVillagesData =
        await rootBundle.loadString("assets/JSON Files/Villages.json");
    List<dynamic> villagesList =
        await json.decode(jsonVillagesData) as List<dynamic>;
    setState(() {
      allVillages = villagesList;
    });
  }

  fetchTalukas(String? district) {
    setState(() {
      availableTalukas = allTalukas
          .where((element) => element["parentId"] == district)
          .toList();
    });
  }

  fetchVillages(String? taluka) {
    setState(() {
      availableVillages = allVillages
          .where((element) => element["parentId"] == taluka)
          .toList();
    });
  }

  Future<void> getUserData() async {
    var document = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get();
    if (document.exists) {
      var data = document.data()!;
      setState(() {
        selectedAcre = data["Acre"];
        selectedGuntha = data["Guntha"];
        selectedMainCrop = data["Main Crop"];
        selectedInternalCrop = data["Internal Crop"];
        selectedInrrigationType = data["Irrigation Type"];
        selectedInrrigationSource = data["Irrigation Source"];
        selectedDistrict = data["District"];
        selectedTaluka = data["Taluka"];
        selectedVillage = data["Village"];
        fetchTalukas(selectedDistrict);
        fetchVillages(selectedTaluka);
      });
      Future.delayed(Duration(seconds: 7), () {
        setState(() {
          loading = false;
        });
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}
