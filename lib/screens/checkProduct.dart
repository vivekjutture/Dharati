import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class CheckProduct extends StatefulWidget {
  const CheckProduct({super.key});
  State<CheckProduct> createState() => _CheckProductState();
}

class _CheckProductState extends State<CheckProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "खरेदीसाठी पर्याय",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
    );
  }
}
