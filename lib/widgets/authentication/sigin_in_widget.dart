import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/auth_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/models/validations.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/views/authentication/forgot_password_screen.dart';
import 'package:tourism/widgets/mytextfield.dart';

class SigninWidget extends StatefulWidget {
  SigninWidget({Key? key}) : super(key: key);

  @override
  State<SigninWidget> createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  var globalKey = GlobalKey<FormState>();

  final AuthenticationController controller =
      Get.put(AuthenticationController());
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth - 50,
      child: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text("E-mail"),
            const SizedBox(height: 10),
            MyTextfield(
              description: textFieldType.email,
              controller: controller.emailCtr,
              validator: (value) => Validations.validateEmail(value),
            ),
            const SizedBox(height: 20),
            const Text("Password"),
            const SizedBox(height: 10),
            MyTextfield(
              description: textFieldType.password,
              controller: controller.passwordCtr,
              validator: (value) => Validations.validatePasswrd(value),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("forget your"),
                TextButton(
                    onPressed: () =>
                        Get.toNamed(ForgotPasswordScreen.routeName),
                    child: const Text("password?",
                        style: TextStyle(color: myPrimaryColor))),
              ],
            ),
            StatefulBuilder(builder: (context, btnSetState) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (globalKey.currentState!.validate()) {
                      btnSetState(() {
                        loading = true;
                      });
                      controller
                          .signIn(context)
                          .then((value) => btnSetState(() => loading = false));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(myPrimaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white)))
                      : const Text("Sign in", style: TextStyle(fontSize: 17)),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
