import 'package:cloud_firestore/cloud_firestore.dart';
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
          Get.snackbar(
            "Error",
            e.message!,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            isDismissible: true,
            dismissDirection: DismissDirection.horizontal,
            margin: EdgeInsets.all(15),
            forwardAnimationCurve: Curves.easeOutBack,
            colorText: Colors.white,
          );
        },
        codeSent: (verificationId, resendToken) {
          this.verifyId.value = verificationId;
          Get.toNamed("/otp");
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verifyId.value = verificationId;
        },
        timeout: Duration(seconds: 60),
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "OTP Failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: this.verifyId.value, smsCode: otp);
      var credentials = await _auth.signInWithCredential(credential);
      return credentials.user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
    }
    return false;
  }

  logOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
    }
  }

  delete() async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
    }
  }

  // Database Operations

  Future<void> addData(
      String acre,
      String guntha,
      String mainCrop,
      String internalCrop,
      String irrigationType,
      String irrigationSource,
      String district,
      String taluka,
      String village) async {
    final user = _auth.currentUser!;
    final id = user.uid;
    final phoneNo = user.phoneNumber;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(
          {
            "ID": id,
            "Phone Number": phoneNo,
            "Acre": acre,
            "Guntha": guntha,
            "Main Crop": mainCrop,
            "Internal Crop": internalCrop,
            "Irrigation Type": irrigationType,
            "Irrigation Source": irrigationSource,
            "District": district,
            "Taluka": taluka,
            "Village": village,
          },
        )
        .then((value) => Get.snackbar(
              "Sucess",
              "Data Uploaded Successfully!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              margin: EdgeInsets.all(15),
              forwardAnimationCurve: Curves.easeOutBack,
              colorText: Colors.white,
            ))
        .onError((error, stackTrace) => Get.snackbar(
              "Error",
              error.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              margin: EdgeInsets.all(15),
              forwardAnimationCurve: Curves.easeOutBack,
              colorText: Colors.white,
            ));
  }
}
