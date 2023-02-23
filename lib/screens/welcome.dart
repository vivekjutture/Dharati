import 'dart:convert';
import 'package:dharati/widgets/NavDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  //variables
  final user = FirebaseAuth.instance.currentUser!;

  List<dynamic> dist = [];
  String? distSel = "";

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

  String? selectedAcre = "0";
  String? selectedGuntha = "0";

  @override
  void initState() {
    createDistList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome to Dharati",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Total Land",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.green.shade500, width: 2)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            value: selectedAcre,
                            borderRadius: BorderRadius.circular(5),
                            items: _acres
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedAcre = value;
                                print(selectedAcre);
                              });
                            },
                            onSaved: ((newValue) => setState(() {
                                  selectedAcre = newValue;
                                })),
                            menuMaxHeight: 250,
                            decoration: InputDecoration(
                              labelText: "Acre",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.green.shade900,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                            value: selectedGuntha,
                            borderRadius: BorderRadius.circular(5),
                            items: _gunthas
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) => setState(() {
                              selectedGuntha = value;
                              print(selectedGuntha);
                            }),
                            onSaved: ((newValue) => setState(() {
                                  selectedGuntha = newValue;
                                })),
                            menuMaxHeight: 250,
                            decoration: InputDecoration(
                              labelText: "Guntha",
                              labelStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.green.shade900,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
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

  Future<void> createDistList() async {
    final jsonData =
        await rootBundle.loadString("assets/JSON Files/Districts.json");
    List<dynamic> res = await json.decode(jsonData) as List<dynamic>;
    setState(() {
      dist = res;
    });
  }
}
