import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/forget_password_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/models/validations.dart';
import 'package:tourism/widgets/mytextfield.dart';

class ChangePassWidget extends StatelessWidget {
  ChangePassWidget({Key? key}) : super(key: key);
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  MyTextfield pass = MyTextfield();
  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter your new password"),
                const SizedBox(height: 10),
                MyTextfield(
                    controller: controller.passwordCtr,
                    description: textFieldType.password,
                    validator: (value) => Validations.validatePasswrd(value)),
                const SizedBox(height: 20),
                const Text("Re-enter your password"),
                const SizedBox(height: 10),
                MyTextfield(
                    controller: controller.repasswordCtr,
                    description: textFieldType.password,
                    validator: (value) {
                      if (value.toString() != controller.passwordCtr.text) {
                        return "Dismatch password";
                      }
                    }),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(myPrimaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
              onPressed: () {
                if (globalKey.currentState!.validate()) {
                  controller.changePassword();
                }
              },
              child: const Text("send")),
        )
      ],
    );
  }
}
