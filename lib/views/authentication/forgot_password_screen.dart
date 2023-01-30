import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/auth_ctrl.dart';
import 'package:tourism/controllers/forget_password_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/widgets/forgetpassword/change_password_widget.dart';
import 'package:tourism/widgets/forgetpassword/enter_otp_widget.dart';
import 'package:tourism/widgets/forgetpassword/resignin_widget.dart';
import 'package:tourism/widgets/forgetpassword/sent_otp_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/ForgotPassword";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.getProportionateScreenHeight(30),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Tourism",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor),
              ),
            ),
            SizedBox(
              height: SizeConfig.getProportionateScreenHeight(30),
            ),
            Obx(() => Container(
                width: SizeConfig.getProportionateScreenWidth(385),
                height: controller.forgotState == forgotpassState.re_signin
                    ? SizeConfig.getProportionateScreenHeight(460)
                    : SizeConfig.getProportionateScreenHeight(350),
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: myTextFieldBorderColor),
                ),
                child: controller.forgotState == forgotpassState.send_otp
                    ? SentOtpWidget()
                    : controller.forgotState == forgotpassState.enter_otp
                        ? EnterOtpWidget()
                        : controller.forgotState ==
                                forgotpassState.change_password
                            ? ChangePassWidget()
                            : Resignin())),
          ],
        ),
      )),
    );
  }
}
