import 'package:flutter/cupertino.dart';
import 'package:tourism/constants.dart';

class Validations {
  static String? validateName(String name) {
    if (name.trim().length < 2) {
      return "Invalid name";
    }
  }

  static String? validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      return null;
    } else {
      return "Invalid email";
    }
  }

  static String? validatePhone(String phone) {
    if (phone.length == 11 && phone.toString().startsWith("01")) {
      return null;
    } else {
      return "invalid phone number";
    }
  }

  static String? validatePasswrd(String password) {
    if (password.toString().trim().isEmpty) {
      return "Enter a password!";
    } else if (password.toString().trim().length < 6) {
      return "Too short password!";
    } else {
      return null;
    }
  }

  static String? validateRepassword({repassword, password}) {
    if (repassword.toString().trim() == password.toString().trim()) {
      return null;
    } else {
      return "Dismatch password";
    }
  }
}
