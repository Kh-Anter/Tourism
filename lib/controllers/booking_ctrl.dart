import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BookingCtrl extends GetxController {
  TextEditingController fnameCtr = TextEditingController();
  TextEditingController lnameCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController countryCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController destinationCtr = TextEditingController();
  TextEditingController q1Ctr = TextEditingController();
  TextEditingController q2Ctr = TextEditingController();
  TextEditingController adultsCtr = TextEditingController();
  TextEditingController childrenCtr = TextEditingController();
  TextEditingController fromCtr = TextEditingController();
  TextEditingController toCtr = TextEditingController();

  Future addBookingToFirestore() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await users.doc(uid).set({
      'fname': fnameCtr.text,
      'lname': lnameCtr.text,
      'phoneNum': phoneCtr.text,
      'company': countryCtr.text,
      'email': emailCtr.text,
      'destination': destinationCtr.text,
      'q1': q1Ctr.text,
      'q2': q2Ctr.text,
      'adults': adultsCtr.text,
      'from': fromCtr.text,
      'to': toCtr.text,
    });
  }

// if the user booking a trip before , this function return his data ;
  Future readUserData() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    var result = await users.doc(uid).get();
    if (result != null) {
      fnameCtr.text = result['fname'];
      lnameCtr.text = result['lname'];
      phoneCtr.text = result['phoneNum'];
      countryCtr.text = result['company'];
      emailCtr.text = result['email'];
      destinationCtr.text = result['destination'];
      q1Ctr.text = result['q1'];
      q2Ctr.text = result['q2'];
      adultsCtr.text = result['adults'];
      fromCtr.text = result['from'];
      toCtr.text = result['to'];
    }
  }
}
