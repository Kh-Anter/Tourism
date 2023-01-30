import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tourism/controllers/forget_password_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/views/authentication/forgot_password_screen.dart';
import 'package:tourism/views/home_screen.dart';

class AuthenticationController extends GetxController {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController repasswordCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  late String _verificationId;
  RxBool isSignIn = true.obs;
  changeAuthState() {
    isSignIn.value = !isSignIn.value;
    update();
  }

  Future<void> signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailCtr.text, password: passwordCtr.text)
          .then((value) => Get.offAndToNamed(HomeScreen.routeName));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          mySnackBar(context, "Wrong password!");
          break;
        case 'user-not-found':
          mySnackBar(context, "User not found");
          break;
        case 'user-disabled':
          mySnackBar(context, "User disabled");
          break;
        case 'too-many-requests':
          mySnackBar(context, "An error occured , try again later");
      }
    }
  }

  Future signUp(BuildContext context) async {
    if (!await checkInternet()) {
      mySnackBar(context, "No internet connection");
    } else if (await checkIfEmailExist()) {
      mySnackBar(context, "This email already exist!");
    } else {
      sendOTP(context, false);
    }
  }

  Future forgotPass(BuildContext context) async {
    if (!await checkInternet()) {
      mySnackBar(context, "No internet connection");
    } else {
      sendOTP(context, true);
    }
  }

/* state parameter to know why the method called (for signup or forget password) 
   state = true (mean change password)
   state = fale (mean signup) */
  Future sendOTP(BuildContext context, bool state) async {
    var auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
          phoneNumber:
              '+2${state ? controller.phoneCtr.value.text : phoneCtr.value.text}',
          codeSent: (String verificationId, int? resendToken) {
            _verificationId = verificationId;
            controller.changeForgotState(forgotpassState.enter_otp);
            Get.toNamed(ForgotPasswordScreen.routeName);
          },
          verificationCompleted: (PhoneAuthCredential credential) {
            controller.otpCode.text = credential.smsCode.toString();
          },
          verificationFailed: (FirebaseAuthException e) {
            mySnackBar(context, '----faild-----${e.message}');
          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (verificationId) {});
    } catch (e) {
      mySnackBar(context, e.toString());
    }
  }

  Future<bool> checkIfEmailExist() async {
    final auth = FirebaseAuth.instance;
    final List<String> otherMethod =
        await auth.fetchSignInMethodsForEmail(emailCtr.text);
    return otherMethod.length != 0;
  }

  void submitOTP() async {
    try {
      var auth = FirebaseAuth.instance;
      await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationId,
              smsCode: controller.otpCode.text))
          .then((value) {
        if (value.user != null) {
          if (controller.currentFlag == flag.signup) {
            linkWithEmail();
            Get.offAndToNamed(HomeScreen.routeName);
          } else {
            controller.changeForgotState(forgotpassState.change_password);
          }
        }
      });
    } catch (e) {
      print("-------------------------- $e");
    }
  }

  linkWithEmail() async {
    final credential = EmailAuthProvider.credential(
        email: emailCtr.text, password: passwordCtr.text);
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
  }

  Future<bool> checkInternet() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.none ||
        result == ConnectivityResult.bluetooth) {
      return false;
    } else {
      return true;
    }
  }

  mySnackBar(BuildContext ctx, String text) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(text)));
  }
}
