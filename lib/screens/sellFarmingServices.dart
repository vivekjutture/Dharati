import 'package:flutter/material.dart';

class SellFarmingServices extends StatefulWidget {
  const SellFarmingServices({super.key});

  @override
  State<SellFarmingServices> createState() => _SellFarmingServicesState();
}

class _SellFarmingServicesState extends State<SellFarmingServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "सेवा नोंदणी",
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