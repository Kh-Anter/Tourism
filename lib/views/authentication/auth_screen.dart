import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/controllers/auth_ctrl.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/widgets/authentication/sigin_in_widget.dart';
import 'package:tourism/widgets/authentication/sign_up_widget.dart';
import '/constants.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = "/AuthScreen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthenticationController controller =
      Get.put(AuthenticationController());
  SizeConfig size = SizeConfig();
  TextStyle selected = const TextStyle(
      color: Colors.black,
      fontSize: 34,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);
  TextStyle unselected = const TextStyle(
    color: mySecondTextColor,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    size.init(context);
    sizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeConfig.getProportionateScreenHeight(10),
                  ),
                  const Text(
                    "Tourism",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: myPrimaryColor),
                  ),
                  SizedBox(
                    height: SizeConfig.getProportionateScreenHeight(10),
                  ),
                  Obx(() => Text(controller.isSignIn.value
                      ? "welcome, sign in to continue"
                      : "Create new account")),
                  SizedBox(
                    height: SizeConfig.getProportionateScreenHeight(20),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/auth.png",
                      width: SizeConfig.getProportionateScreenWidth(250),
                      height: SizeConfig.getProportionateScreenHeight(250),
                    ),
                  ),
                  Obx(() => Container(
                      alignment: Alignment.center,
                      child: controller.isSignIn.value
                          ? SigninWidget()
                          : const SignupWidget())),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.isSignIn.value
                              ? "don't have an account?"
                              : "have an account?"),
                          TextButton(
                              onPressed: () => controller.changeAuthState(),
                              child: Text(
                                controller.isSignIn.value ? "Signup" : "Signin",
                                style: const TextStyle(color: myPrimaryColor),
                              )),
                        ],
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}
