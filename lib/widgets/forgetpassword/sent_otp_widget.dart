import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/auth_ctrl.dart';
import 'package:tourism/controllers/forget_password_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/widgets/mytextfield.dart';

class SentOtpWidget extends StatefulWidget {
  SentOtpWidget({Key? key}) : super(key: key);

  @override
  State<SentOtpWidget> createState() => _SentOtpWidgetState();
}

class _SentOtpWidgetState extends State<SentOtpWidget> {
  refresh() {
    setState(() {});
  }

  ForgotPasswordController controller = Get.put(ForgotPasswordController());
  AuthenticationController authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Type your phone number"),
        //  phone_num,
        MyTextfield(
          description: textFieldType.phoneNum,
          controller: controller.phoneCtr,
          onchange: refresh,
          validator: (value) {
            if (value.toString().trim().length < 1) {
              return "Enter your phone number";
            }
          },
        ),
        const Text("We texted you a code to verify your \n phone number"),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(myPrimaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
              onPressed: controller.phoneCtr.value.text == ""
                  ? null
                  : () {
                      controller.currentFlag == flag.forgotPassword
                          ? authController.forgotPass(context)
                          : authController.signUp(context);
                    },
              child: const Text("send")),
        )
      ],
    );
  }
}
