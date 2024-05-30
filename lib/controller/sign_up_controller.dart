import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignUpController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController button = TextEditingController();

  RxBool enableButton = false.obs;

  final FirebaseAuth auth  =  FirebaseAuth.instance;

  @override
  void onInit() {
    email.addListener(() {
      enableButton.value = email.text.isNotEmpty;
    });
    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();

  }

  onSignUp(){
    print("connect");
    createAccount(email.text, password.text);
  }

  Future<void> createAccount(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Account Created");
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "weak-password") {
        print("Weak Password");
      } else if (ex.code == "email-already-in-use") {
        print("Email Already exists Login Please !");
      }
    } catch (ex) {
      print(ex);
    }
  }
}


