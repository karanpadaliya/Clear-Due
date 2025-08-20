import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Signup function
  Future<void> signUp(
      String name,
      String phone,
      String email,
      String password,
      String referralCode,
      ) async {
    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage.value = "⚠ Please fill all required fields";
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = "";

      /// Firebase Auth signup
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      /// Firestore user data
      await _firestore.collection("users").doc(uid).set({
        "uid": uid,
        "name": name,
        "phone": phone,
        "email": email,
        "referralCode": referralCode.isNotEmpty ? referralCode : null,
        "role": "user",
        "createdAt": FieldValue.serverTimestamp(),
      });

      /// Debug print
      print("✅ User Created: $uid");
      print("✅ User Data Saved in Firestore");

      /// Success snackbar
      Get.snackbar(
        "Success 🎉",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? "Signup failed";
      Get.snackbar(
        "Auth Error",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        "Error",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
