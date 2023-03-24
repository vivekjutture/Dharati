import 'package:flutter/material.dart';

class BuyFarmingServices extends StatefulWidget {
  const BuyFarmingServices({super.key});

  @override
  State<BuyFarmingServices> createState() => _BuyFarmingServicesState();
}

class _BuyFarmingServicesState extends State<BuyFarmingServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "शेती सेवा",
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
