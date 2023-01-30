import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/auth_ctrl.dart';
import 'package:tourism/controllers/forget_password_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/models/validations.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/widgets/mytextfield.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  bool loading = false;
  var globalKey = GlobalKey<FormState>();
  bool acceptTerms = false;
  final AuthenticationController authController =
      Get.put(AuthenticationController());
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth - 50,
      child: Form(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text("Name"),
            MyTextfield(
              description: textFieldType.name,
              controller: authController.nameCtr,
              validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return "Enter your name!";
                } else
                  return null;
              },
            ),
            const SizedBox(height: 5),
            const Text("E-mail"),
            MyTextfield(
              description: textFieldType.email,
              controller: authController.emailCtr,
              validator: (value) => Validations.validateEmail(value),
            ),
            const SizedBox(height: 5),
            const Text("Phone number"),
            MyTextfield(
              description: textFieldType.phoneNum,
              controller: authController.phoneCtr,
            ),
            const SizedBox(height: 5),
            const Text("Password"),
            MyTextfield(
              description: textFieldType.password,
              controller: authController.passwordCtr,
              validator: (value) => Validations.validatePasswrd(value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        acceptTerms = value!;
                      });
                    }),
                const Text("agree to our"),
                TextButton(
                    onPressed: () {},
                    child: const Text("Terms and Conditions",
                        style: TextStyle(color: myPrimaryColor))),
              ],
            ),
            StatefulBuilder(
              builder: (context, btnSetState) => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: acceptTerms
                      ? () {
                          FocusScope.of(context).unfocus();
                          if (globalKey.currentState!.validate()) {
                            btnSetState(() {
                              loading = true;
                            });
                            controller.currentFlag = flag.signup;
                            authController.signUp(context).then(
                                (value) => btnSetState(() => loading = false));
                          }
                        }
                      : null,
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
                      : const Text("Sign up", style: TextStyle(fontSize: 17)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
