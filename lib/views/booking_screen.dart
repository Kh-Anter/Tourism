import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/booking_ctrl.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/models/validations.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/views/check_out_screen.dart';
import 'package:tourism/widgets/footer.dart';
import 'package:tourism/widgets/mytextfield.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({Key? key}) : super(key: key);
  static const routeName = "/Booking";
  SizeConfig size = SizeConfig();
  final BookingCtrl controller = Get.put(BookingCtrl());
  bool loading = false;
  final globalKey = GlobalKey<FormState>();
  late final readBookingData = controller.readUserData();

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: readBookingData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: SizeConfig.getProportionateScreenHeight(30)),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text("Tourism",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: myPrimaryColor)),
                    ),
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: const Text(
                            "Fill out the form bellow and our team will contact with you")),
                    Center(
                      child: SizedBox(
                          width: SizeConfig.screenWidth - 60,
                          child: Form(
                            key: globalKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("First Name:"),
                                  myCustomTextField(
                                      description: textFieldType.name,
                                      controller: controller.fnameCtr,
                                      validator: (value) =>
                                          Validations.validateName(value)),
                                  const Text("Last Name:"),
                                  myCustomTextField(
                                      description: textFieldType.name,
                                      controller: controller.lnameCtr,
                                      validator: (value) =>
                                          Validations.validateName(value)),
                                  const Text("Phone Number:"),
                                  myCustomTextField(
                                      description: textFieldType.phoneNum,
                                      controller: controller.phoneCtr,
                                      validator: (value) =>
                                          Validations.validatePhone(value)),
                                  const Text("Country:"),
                                  myCustomTextField(
                                    description: textFieldType.name,
                                    controller: controller.countryCtr,
                                    // validator: (value)=>Validations.validateName(value),
                                  ),
                                  const Text("E-mail:"),
                                  myCustomTextField(
                                    description: textFieldType.email,
                                    controller: controller.emailCtr,
                                    validator: (value) =>
                                        Validations.validateEmail(value),
                                  ),
                                  const Text("Destination:"),
                                  myCustomTextField(
                                    description: textFieldType.name,
                                    controller: controller.destinationCtr,
                                    // validator: (value)=>Validations.validateName(value),
                                  ),
                                  const Text(
                                      "Would you like camping or hotel as accommodation?"),
                                  myCustomTextField(
                                    description: textFieldType.name,
                                    controller: controller.q1Ctr,
                                  ),
                                  const Text(
                                      "would you like it to be a relaxing or adventurous trip?"),
                                  myCustomTextField(
                                    description: textFieldType.name,
                                    controller: controller.q2Ctr,
                                  ),
                                  const Text("Adults:"),
                                  myCustomTextField(
                                    description: textFieldType.name,
                                    controller: controller.adultsCtr,
                                  ),
                                  const Text("Children:"),
                                  myCustomTextField(
                                    description: textFieldType.name,
                                    controller: controller.childrenCtr,
                                  ),
                                  const Text("From:"),
                                  myCustomTextField(
                                    description: textFieldType.email,
                                    controller: controller.fromCtr,
                                    validator: (value) =>
                                        Validations.validateEmail(value),
                                  ),
                                  const Text("To"),
                                  myCustomTextField(
                                    description: textFieldType.email,
                                    controller: controller.toCtr,
                                    validator: (value) =>
                                        Validations.validateEmail(value),
                                  ),
                                  StatefulBuilder(
                                      builder: (context, btnSetState) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          if (globalKey.currentState!
                                              .validate()) {
                                            btnSetState(() => loading = true);
                                            controller
                                                .addBookingToFirestore()
                                                .then((value) {
                                              btnSetState(
                                                  () => loading = false);
                                              Get.toNamed(
                                                  CheckOutScreen.routeName);
                                            });
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    myPrimaryColor),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        child: loading
                                            ? const SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color:
                                                                Colors.white)))
                                            : const Text("Submit",
                                                style: TextStyle(fontSize: 17)),
                                      ),
                                    );
                                  })
                                ]),
                          )),
                    ),
                    const SizedBox(height: 20),
                    Footer()
                  ]),
            );
          }
        },
      )),
    );
  }

  myCustomTextField({description, controller, validator}) {
    return Column(children: [
      const SizedBox(height: 10),
      MyTextfield(
        description: description,
        controller: controller,
        validator: validator,
      ),
      const SizedBox(height: 20)
    ]);
  }
}
