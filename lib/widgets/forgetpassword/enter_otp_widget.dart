import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/auth_ctrl.dart';
import 'package:tourism/controllers/forget_password_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/widgets/loading.dart';
import 'package:tourism/widgets/mytextfield.dart';

class EnterOtpWidget extends StatefulWidget {
  EnterOtpWidget({Key? key}) : super(key: key);

  @override
  State<EnterOtpWidget> createState() => _EnterOtpWidgetState();
}

class _EnterOtpWidgetState extends State<EnterOtpWidget> {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  final AuthenticationController authController =
      Get.put(AuthenticationController());

  bool resentCodeBtn = false;
  bool sentOTP = false;
  bool resendOTP = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Type a code"),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: (SizeConfig.screenWidth - 50) / 1.5,
              child: MyTextfield(
                description: textFieldType.phoneNum,
                controller: controller.otpCode,
                validator: (value) {
                  if (value.toString().trim().length < 1) {
                    return "enter the otp code";
                  }
                },
                onchange: refresh,
              )),
          SizedBox(
              width: (SizeConfig.screenWidth - 50) / 4,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(myPrimaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  onPressed: () {
                    controller.otpCode.text = "";
                    setState(() => resendOTP = true);
                    if (controller.currentFlag == flag.forgotPassword) {
                      authController
                          .forgotPass(context)
                          .then((value) => setState(() => resendOTP = false));
                    } else {
                      authController
                          .signUp(context)
                          .then((value) => setState(() => resendOTP = false));
                    }
                  },
                  child: resendOTP ? loading() : const Text("Resend"))),
        ]),
        Text(
            "We texted you a code to verify your  \n phone number ${controller.currentFlag == flag.forgotPassword ? controller.phoneCtr.text : authController.phoneCtr.text}"),
        const Text(
            "This code will expired 1 minutes \n after this message. \n If you don't get one,  ask for another \n by pressing on Resend."),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(myPrimaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
              onPressed: controller.otpCode.value.text == ""
                  ? null
                  : () {
                      authController.submitOTP();
                      controller.otpCode.value.text == "";
                    },
              child: sentOTP ? loading() : const Text("send")),
        )
      ],
    );
  }

  refresh() {
    setState(() {});
  }
}
