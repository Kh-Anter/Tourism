import 'package:flutter/material.dart';

Widget loading() {
  return const Center(
    child: SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(color: Colors.white),
    ),
  );
}
