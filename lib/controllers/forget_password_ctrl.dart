import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/widgets/forgetpassword/change_password_widget.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController otpCode = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController repasswordCtr = TextEditingController();

  var currentFlag = flag.forgotPassword;
  var forgotState = forgotpassState.send_otp.obs;
  changeForgotState(newState) {
    forgotState.value = newState;
    update();
  }

  changePassword() async {
    try {
      await FirebaseAuth.instance.currentUser!
          .updatePassword(passwordCtr.text)
          .then((value) => changeForgotState(forgotpassState.re_signin));
    } catch (e) {
      print("------------------$e");
    }
  }
}
