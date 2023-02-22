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
  final user = FirebaseAuth.instance.currentUser!;
  List<dynamic> dist = [];
  String? distSel;
  @override
  void initState() {
    createDistList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Welcome to Dharati"),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      drawer: const NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormHelper.dropDownWidget(
              context,
              "Select District",
              this.distSel,
              this.dist,
              (onChanged) {
                this.distSel = onChanged;
                print("Selected District ${onChanged}");
              },
              (onValidate) {
                return null;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              optionLabel: "label",
              optionValue: "id",
            )
          ],
        ),
      ),
    );
  }

  Future<void> createDistList() async {
    final jsonData = await rootBundle.loadString("assets/JSON Files/Districts.json");
    List<dynamic> res = await json.decode(jsonData) as List<dynamic>;
    setState(() {
      dist = res;
    });
  }
}
