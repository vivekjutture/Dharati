import 'package:dharati/services/FirebaseAllServices.dart';
import 'package:dharati/screens/userDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dharati/screens/phone.dart';
import 'package:dharati/screens/otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dharati/services/firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DharatiApp());
}

class DharatiApp extends StatefulWidget {
  const DharatiApp({super.key});
  @override
  State<DharatiApp> createState() => _DharatiAppState();
}

class _DharatiAppState extends State<DharatiApp> {
  bool userLoggedIn = false;
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FirebaseAllServices());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: userLoggedIn ? const UserDetails() : const PhoneNum(),
      routes: {
        '/phone': (context) => const PhoneNum(),
        '/otp': (context) => const OTPVerification(),
        '/userdetails': (context) => const UserDetails(),
      },
    );
  }

  checkLoginStatus() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          userLoggedIn = true;
        });
      } else {
        setState(() {
          userLoggedIn = false;
        });
      }
    });
  }
}
