
import 'package:dharati/services/FirebaseAllServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class PhoneNum extends StatefulWidget {
  const PhoneNum({super.key});
  //static String verifyId = "";
  static String completeNumber = '#';

  @override
  State<PhoneNum> createState() => _PhoneNumState();
}

class _PhoneNumState extends State<PhoneNum> {
  String countryISOCode = 'IN';

  String number = '#';
  int minLength = 10;
  int maxLength = 10;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Agriculture.jpg',
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
                'Enter Your Mobile Number',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                dropdownTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                initialCountryCode: countryISOCode,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                onChanged: (phone) {
                  countryISOCode = phone.countryISOCode;
                  PhoneNum.completeNumber = phone.completeNumber;
                  number = phone.number;
                  minLength = countries
                      .firstWhere(
                        (country) =>
                            country.code.toLowerCase() ==
                            countryISOCode.toLowerCase(),
                      )
                      .minLength;
                  maxLength = countries
                      .firstWhere(
                        (country) =>
                            country.code.toLowerCase() ==
                            countryISOCode.toLowerCase(),
                      )
                      .maxLength;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    int len = number.length;
                    if (len >= minLength && len <= maxLength) {
                      /*try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        if (kIsWeb) {
                          await auth.verifyPhoneNumber(
                              verificationCompleted: verificationCompleted,
                              verificationFailed: verificationFailed,
                              codeSent: codeSent,
                              codeAutoRetrievalTimeout:
                                  codeAutoRetrievalTimeout);
                        }
                        await auth.verifyPhoneNumber(
                          phoneNumber: completeNumber,
                          verificationCompleted:
                              (PhoneAuthCredential credential) async {
                            await auth.signInWithCredential(credential);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            showSnackBar(context, e.message!);
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            PhoneNum.verifyId = verificationId;
                            Navigator.pushNamed(context, "otp");
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            PhoneNum.verifyId = verificationId;
                          },
                          timeout: const Duration(seconds: 60),
                        );
                      } on FirebaseAuthException catch (e) {
                        showSnackBar(context, e.message!);
                      } catch (e) {
                        showSnackBar(context, "OTP Faild");
                      }*/
                      FirebaseAllServices.instance
                          .phoneAuthentication(PhoneNum.completeNumber);
                      //Navigator.pushNamed(context, "/otp");
                    } else {
                      Get.snackbar(
                        "Error",
                        "Invalid Number",
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
                    'Send the OTP',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
