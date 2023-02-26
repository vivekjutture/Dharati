import 'package:dharati/screens/phone.dart';
import 'package:dharati/services/FirebaseAllServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Agriculture.jpg',
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Phone Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter OTP sent to ${PhoneNum.completeNumber}',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (code) {
                  otp = code;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (otp.length == 6) {
                      /*try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: PhoneNum.verifyId,
                                smsCode: otp);
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(
                            context, "userdetails", (route) => false);
                      } on FirebaseAuthException catch (e) {
                        showSnackBar(context, e.message!);
                      }*/
                      var isVerified =
                          await FirebaseAllServices.instance.verifyOTP(otp);
                      if (isVerified) {
                        Get.offNamedUntil("/userdetails", (route) => false);
                      } else {
                        Get.snackbar(
                          "Error",
                          "OTP Failed!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          isDismissible: true,
                          dismissDirection: DismissDirection.horizontal,
                          margin: EdgeInsets.all(15),
                          forwardAnimationCurve: Curves.easeOutBack,
                          colorText: Colors.white,
                        );
                      }
                    } else {
                      Get.snackbar(
                        "Error",
                        "Invalid OTP",
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
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.offNamedUntil("/phone", (route) => false);
                  },
                  child: Text('Another number?')),
            ],
          ),
        ),
      ),
    );
  }
}
