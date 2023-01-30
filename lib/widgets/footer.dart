import 'package:flutter/material.dart';
import 'package:tourism/constants.dart';

Widget Footer() {
  return Container(
    width: double.infinity,
    height: 190,
    padding: const EdgeInsets.only(top: 20, bottom: 30),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: myPrimaryColor),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: const [
          Text("Tourism \n \n Home \n \n Tour",
              style: TextStyle(fontSize: 24, color: Colors.white)),
        ]),
        Column(
          children: const [
            Text(
                "Call US \n \n +966112233445 \n \n E-mail \n \n Tourism@gmail.com ",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        )
      ],
    ),
  );
}
