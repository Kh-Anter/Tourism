import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/home_ctrl.dart';
import 'package:tourism/size_config.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourism/widgets/footer.dart';

class RegionScreen extends StatelessWidget {
  RegionScreen({Key? key}) : super(key: key);
  static const routeName = "/RegionScreen";
  var region = Get.arguments[0];

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
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            region.name ?? "",
            style: const TextStyle(fontSize: 16, color: myPrimaryColor),
          ),
        ),
        Center(
            child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          width: SizeConfig.screenWidth - 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: mySecondTextColor),
              color: myPrimaryColor),
          child: Text(
            region.description ?? "",
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        )),
        ...List.generate(region.places.length, (index) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: SizeConfig.getProportionateScreenWidth(250),
                    height: SizeConfig.getProportionateScreenHeight(250),
                    child: Image.network(
                      region.places[index]["img"]!,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) =>
                              child,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.white,
                            child: Container(
                              width:
                                  SizeConfig.getProportionateScreenWidth(250),
                              height:
                                  SizeConfig.getProportionateScreenHeight(250),
                              color: Colors.grey,
                            ),
                          );
                        }
                      },
                    )),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: SizeConfig.screenWidth - 50,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(myPrimaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    child: Text(region.places[index]["name"] ?? "",
                        style: const TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 25)
              ],
            ),
          );
        }),
        Center(
          child: SizedBox(
            width: SizeConfig.screenWidth - 50,
            height: 45,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(myPrimaryColor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
              ),
              child:
                  const Text("Back to regions", style: TextStyle(fontSize: 17)),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Footer()
      ],
    ))));
  }
}
