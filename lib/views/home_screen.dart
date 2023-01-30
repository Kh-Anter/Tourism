import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/controllers/home_ctrl.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/views/all_trips_screen.dart';
import 'package:tourism/views/region_screen.dart';
import 'package:tourism/widgets/footer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCtrl controller = Get.put(HomeCtrl());
  late final fetchData = controller.fetchAllRegions();
  @override
  SizeConfig size = SizeConfig();

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: fetchData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
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
                    child: const Text("welcome to Asir tourism")),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/auth.png",
                    width: SizeConfig.getProportionateScreenWidth(250),
                    height: SizeConfig.getProportionateScreenHeight(250),
                  ),
                ),
                Center(
                    child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  padding: const EdgeInsets.all(10),
                  width: SizeConfig.screenWidth - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: myPrimaryColor),
                  child: const Text(
                    "The topography of the Asir region varies,  and it's climate varies, starting from the plains region flourishing with agriculture,  followed by the heights of the Sarawat  mountains range, which exceeds the  height of 2800 m above sea level, then the slopes of the mountains until they reach the coastal plains. ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )),
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 25, left: 35),
                  child: Text(
                    "Regions:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: myPrimaryColor),
                  ),
                ),
                ...List.generate(controller.allRegions.length, (index) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: SizeConfig.getProportionateScreenWidth(250),
                          height: SizeConfig.getProportionateScreenHeight(250),
                          child: Image.network(
                            controller.allRegions[index].img!,
                            frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) =>
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
                                        SizeConfig.getProportionateScreenWidth(
                                            250),
                                    height:
                                        SizeConfig.getProportionateScreenHeight(
                                            250),
                                    color: Colors.grey,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          width: SizeConfig.screenWidth - 50,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed(RegionScreen.routeName,
                                arguments: [controller.allRegions[index]]),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(myPrimaryColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                            child: Text(controller.allRegions[index].name ?? "",
                                style: const TextStyle(fontSize: 17)),
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
                      onPressed: () => Get.toNamed(AllTripScreen.routeName),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(myPrimaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                      ),
                      child: const Text("Tour", style: TextStyle(fontSize: 17)),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Footer()
              ],
            ));
          }
        },
      ),
    ));
  }
}
