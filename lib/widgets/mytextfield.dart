import 'package:flutter/material.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/models/validations.dart';
import 'package:tourism/size_config.dart';

class MyTextfield extends StatefulWidget {
  TextEditingController? controller;
  textFieldType? description;
  int? maxLength;
  Widget? prefex;
  dynamic validator;
  dynamic onchange;

  MyTextfield(
      {Key? key,
      this.controller,
      this.description,
      this.validator,
      this.maxLength,
      this.prefex,
      this.onchange})
      : super(key: key);

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool isHidden = true;
  bool isPass = false;
  TextInputType texttype = TextInputType.text;

  @override
  Widget build(BuildContext context) {
    if (widget.description == textFieldType.email) {
      isPass = false;
      texttype = TextInputType.emailAddress;
    } else if (widget.description == textFieldType.password) {
      isPass = true;
      texttype = TextInputType.visiblePassword;
    } else if (widget.description == textFieldType.phoneNum) {
      isPass = false;
      texttype = TextInputType.number;
    } else if (widget.description == textFieldType.name) {
      isPass = false;
      texttype = TextInputType.text;
    }

    return TextFormField(
      validator: widget.validator,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          prefix: widget.prefex,
          suffix: isPass
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  child: Icon(
                    isHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ))
              : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      keyboardType: texttype,
      maxLength: widget.maxLength,
      controller: widget.controller,
      obscureText: isPass ? (isHidden ? true : false) : false,
      onChanged: (value) => widget.onchange == null ? {} : widget.onchange(),
    );
  }
}
