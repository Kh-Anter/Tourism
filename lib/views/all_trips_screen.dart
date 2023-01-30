import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/home_ctrl.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/views/trip_details_screen.dart';
import 'package:tourism/widgets/footer.dart';

class AllTripScreen extends StatelessWidget {
  AllTripScreen({Key? key}) : super(key: key);
  static const routeName = "/AllTrips";
  final HomeCtrl controller = Get.put(HomeCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
          future: controller.fetchAllTrips(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, top: 30, bottom: 30),
                    child: Text(
                      "Tourism",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: myPrimaryColor),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: SizeConfig.screenWidth - 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(controller.allTrips.length, (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: SizeConfig.getProportionateScreenWidth(
                                      297),
                                  height:
                                      SizeConfig.getProportionateScreenHeight(
                                          152),
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        TripDetailsScreen.routeName,
                                        arguments: [
                                          controller.allTrips[index]
                                        ]),
                                    child: Image.network(
                                      controller.allTrips[index].cover!,
                                      frameBuilder: (context, child, frame,
                                              wasSynchronouslyLoaded) =>
                                          child,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.white,
                                            child: Container(
                                              width: SizeConfig
                                                  .getProportionateScreenWidth(
                                                      250),
                                              height: SizeConfig
                                                  .getProportionateScreenHeight(
                                                      250),
                                              color: Colors.grey,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Text(
                                      controller.allTrips[index].name
                                          .toString(),
                                      style: const TextStyle(fontSize: 14)),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded),
                                    Text(
                                        "  ${controller.allTrips[index].duration.toString()}",
                                        style: const TextStyle(fontSize: 10))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month),
                                    Text(
                                        "  ${controller.allTrips[index].availability.toString()}",
                                        style: const TextStyle(fontSize: 10))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.local_offer_outlined),
                                    Text(
                                        "  From SAR ${controller.allTrips[index].salary.toString()}",
                                        style: const TextStyle(fontSize: 10))
                                  ],
                                ),
                                const SizedBox(height: 15)
                              ],
                            );
                          }),
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "Private Trips ",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const Text(
                              "Customization: \nYou can customize your own trip starting from destination ending with your preferred meals. \n \n Exceptional Experience: \n We promise you an experience of a life time."),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Footer(),
                ],
              ));
            }
          }),
    ));
  }
}
