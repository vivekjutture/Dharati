import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseAllServices extends GetxController {
  static FirebaseAllServices get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  var verifyId = ''.obs;

  Future<void> phoneAuthentication(String phoneNum) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            "तसदीबद्दल क्षमस्व",
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
        "तसदीबद्दल क्षमस्व",
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
        "तसदीबद्दल क्षमस्व",
        "ओटीपी तपासून पहा!",
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
        "तसदीबद्दल क्षमस्व",
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
        "तसदीबद्दल क्षमस्व",
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
        "तसदीबद्दल क्षमस्व",
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
      String seletedFertilizerType) async {
    final user = _auth.currentUser!;
    final id = user.uid;
    final phoneNo = user.phoneNumber;
    await db.collection("New Users").doc(id).set(
      {
        "ID": id,
        "Phone Number": phoneNo,
        "Acre": acre,
        "Guntha": guntha,
        "Main Crop": mainCrop,
        "Internal Crop": internalCrop,
        "Irrigation Type": irrigationType,
        "Irrigation Source": irrigationSource,
        "Fertilizer Type": seletedFertilizerType,
      },
      SetOptions(merge: true),
    ).then((value) {
      Get.snackbar(
        "धन्यवाद",
        "माहिती यशस्वीरित्या जतन केली आहे!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
      Future.delayed(const Duration(seconds: 5), () {
        Get.toNamed("/dosageCalculator");
      });
    }).onError((error, stackTrace) {
      Get.snackbar(
        "तसदीबद्दल क्षमस्व",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
    });
  }

  Future<void> addLocationdata(
      String district, String taluka, String village, String nextPage) async {
    final user = _auth.currentUser!;
    final id = user.uid;
    await db.collection("New Users").doc(id).set(
      {
        "District": district,
        "Taluka": taluka,
        "Village": village,
      },
      SetOptions(merge: true),
    ).then((value) {
      Get.snackbar(
        "धन्यवाद",
        "माहिती यशस्वीरित्या जतन केली आहे!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
      Future.delayed(const Duration(seconds: 5), () {
        Get.toNamed(nextPage);
      });
    }).onError((error, stackTrace) {
      Get.snackbar(
        "तसदीबद्दल क्षमस्व",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.all(15),
        forwardAnimationCurve: Curves.easeOutBack,
        colorText: Colors.white,
      );
    });
  }
}
