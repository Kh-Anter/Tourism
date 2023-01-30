import 'package:flutter/material.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/models/enums.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/widgets/footer.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key? key}) : super(key: key);
  static const routeName = "/CheckOut";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var paymentway = paymentMethod.Mada;
  bool acceptTerms = false;
  SizeConfig size = SizeConfig();
  List<Widget> allTickets = [];

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth - 60,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Text("CAMPINT IN THE FARM",
                          style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Icon(Icons.local_offer_outlined),
                          SizedBox(width: 5),
                          Text(
                            "From SAR 200",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 5),
                          Text("Availability : 01 - 05 August",
                              style: TextStyle(fontSize: 10))
                        ],
                      ),
                      const SizedBox(height: 20),
                      orederInformation(),
                      ...allTickets,
                      IconButton(
                          onPressed: () {
                            setState(() {
                              allTickets.add(ticket());
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline_outlined,
                              size: 35, color: myPrimaryColor)),
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
                      const Text("Payment Information"),
                      const SizedBox(height: 10),
                      allPaymentMethods(),
                      const SizedBox(height: 10),
                      const Text(
                          "Pay with credit / Depit card / Mada debit card "),
                      const SizedBox(height: 20),
                      visaPaymentInformation(),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(myPrimaryColor)),
                          onPressed: acceptTerms ? () {} : null,
                          child: const Text("Check Out"))
                    ],
                  ),
                ),
              ),
              Footer()
            ],
          ),
        ),
      ),
    );
  }

  Widget orederInformation() {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      width: SizeConfig.screenWidth / 1.5,
//height: 260,
      decoration: BoxDecoration(
          border: Border.all(color: myPrimaryColor),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("First Name"),
          myCheckoutTextField(),
          Text("Last Name"),
          myCheckoutTextField(),
          Text("Email"),
          myCheckoutTextField(),
          Text("Phone Number"),
          myCheckoutTextField(),
        ],
      ),
    );
  }

  Widget allPaymentMethods() {
    return StatefulBuilder(
      builder: (context, rowState) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: paymentway == paymentMethod.Mada
                  ? BoxDecoration(
                      border: Border.all(color: myPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(5))
                  : null,
              width: 50,
              height: 50,
              child: InkWell(
                child: Image.asset(
                  "assets/images/payment/Mada.png",
                ),
                onTap: () => rowState(() => paymentway = paymentMethod.Mada),
              )),
          Container(
              decoration: paymentway == paymentMethod.Visa
                  ? BoxDecoration(
                      border: Border.all(color: myPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(5))
                  : null,
              width: 50,
              height: 50,
              child: InkWell(
                child: Image.asset(
                  "assets/images/payment/Visa.png",
                ),
                onTap: () => rowState(() => paymentway = paymentMethod.Visa),
              )),
          Container(
              decoration: paymentway == paymentMethod.ApplePay
                  ? BoxDecoration(
                      border: Border.all(color: myPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(5))
                  : null,
              width: 50,
              height: 50,
              child: InkWell(
                child: Image.asset(
                  "assets/images/payment/Apple-Pay.png",
                ),
                onTap: () =>
                    rowState(() => paymentway = paymentMethod.ApplePay),
              )),
        ],
      ),
    );
  }

  Widget visaPaymentInformation() {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Card Number"),
          // const SizedBox(height: 5),
          SizedBox(
              width: SizeConfig.screenWidth - 100,
              child: myCheckoutTextField()),
          // const SizedBox(height: 5),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text("Expiry Month"), Text("Expiry Year")]),
          //const SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            myCheckoutTextField(width: (SizeConfig.screenWidth - 100) / 2),
            myCheckoutTextField(width: (SizeConfig.screenWidth - 100) / 2)
          ]),
          Text("CVC Number"),

          myCheckoutTextField(width: 100.0)
        ],
      ),
    );
  }

  Widget ticket() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text("Tiket ${allTickets.length + 1}"),
        const SizedBox(height: 8),
        Container(
          width: SizeConfig.screenWidth / 1.5,
          height: 210,
          decoration: BoxDecoration(
              border: Border.all(color: myPrimaryColor),
              borderRadius: BorderRadius.circular(20)),
          child: Stack(fit: StackFit.loose, children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("First Name"),
                  myCheckoutTextField(),
                  const Text("Last Name"),
                  myCheckoutTextField(),
                  const Text("E-Mail"),
                  myCheckoutTextField(),
                ],
              ),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                    icon: const Icon(Icons.close),
                    color: myPrimaryColor,
                    onPressed: () {
                      setState(() {
                        allTickets.removeLast();
                      });
                    }))
          ]),
        ),
      ],
    );
  }

  Widget myCheckoutTextField(
      {validator, texttype, maxLength, controller, width}) {
    return SizedBox(
      width: width,
      height: 40,
      child: TextFormField(
        validator: validator,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            contentPadding: const EdgeInsets.only(left: 10, right: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: myPrimaryColor),
              borderRadius: BorderRadius.circular(10.0),
            )),
        keyboardType: texttype,
        maxLength: maxLength,
        controller: controller,
      ),
    );
  }
}
