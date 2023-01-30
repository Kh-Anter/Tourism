import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/views/authentication/auth_screen.dart';

class Resignin extends StatelessWidget {
  const Resignin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/auth.png",
            width: SizeConfig.getProportionateScreenWidth(250),
            height: SizeConfig.getProportionateScreenHeight(250),
          ),
        ),
        Text(
            "you have successfully change your password. \n please use the new password when Sign in. "),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Get.offAndToNamed(AuthScreen.routeName),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(myPrimaryColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
            ),
            child: const Text("Sign in", style: TextStyle(fontSize: 17)),
          ),
        )
      ],
    );
  }
}
