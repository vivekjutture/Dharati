import 'package:dharati/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseAllServices extends GetxController {
  static FirebaseAllServices get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verifyId = ''.obs;

  Future<void> phoneAuthentication(
      String phoneNum, BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message!);
        },
        codeSent: (verificationId, resendToken) {
          this.verifyId.value = verificationId;
          Navigator.pushNamed(context, "/otp");
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verifyId.value = verificationId;
        },
        timeout: Duration(seconds: 60),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!);
    } catch (e) {
      Get.snackbar("Error", "OTP Faild");
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: this.verifyId.value, smsCode: otp);
      var credentials = await _auth.signInWithCredential(credential);
      return credentials.user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!);
    }
    return false;
  }

  logOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!);
    }
  }

  delete() async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message!);
    }
  }
}
