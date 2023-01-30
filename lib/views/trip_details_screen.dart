import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/views/booking_screen.dart';
import 'package:tourism/views/check_out_screen.dart';
import 'package:tourism/widgets/footer.dart';

class TripDetailsScreen extends StatelessWidget {
  TripDetailsScreen({Key? key}) : super(key: key);
  static const routeName = "/TripDetails";
  var trip = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: SizeConfig.getProportionateScreenWidth(297),
                height: SizeConfig.getProportionateScreenHeight(152),
                child: Image.network(
                  trip.cover!,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) => child,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          width: SizeConfig.getProportionateScreenWidth(250),
                          height: SizeConfig.getProportionateScreenHeight(250),
                          color: Colors.grey,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(trip.name.toString(),
                    style: const TextStyle(fontSize: 14)),
              ),
              Row(
                children: [
                  const Icon(Icons.local_offer_outlined),
                  Text("  From SAR ${trip.salary.toString()}",
                      style: const TextStyle(fontSize: 10)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(BookingScreen.routeName),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(myPrimaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    child: const Text("Proceed Booking",
                        style: TextStyle(fontSize: 15)),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  Text("  ${trip.availability.toString()}",
                      style: const TextStyle(fontSize: 10))
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.access_time_rounded),
                  Text("  ${trip.duration.toString()}",
                      style: const TextStyle(fontSize: 10))
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.person),
                  Text("  +${trip.age.toString()}",
                      style: const TextStyle(fontSize: 10))
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.group),
                  Text("  ${trip.count.toString()}",
                      style: const TextStyle(fontSize: 10))
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.check),
                  Text("  Weather forecast ${trip.weather.toString()}",
                      style: const TextStyle(fontSize: 10))
                ],
              ),
              if (trip.camping.isNotEmpty) buildCamping(),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.insert_drive_file_outlined),
                  Text("  About the trip:", style: TextStyle(fontSize: 10))
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price includes:", style: TextStyle(fontSize: 10)),
                  const SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buildPriceIncludes())
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price excludes:", style: TextStyle(fontSize: 10)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buildPriceExclude()),
                  )
                ],
              ),
              if (trip.itinerary.isNotEmpty) buildItinerary(),
              if (trip.FAQ.isNotEmpty) buildFAQ(),
              const SizedBox(height: 15)
            ]),
          )),
          Footer()
        ]))));
  }

  buildPriceIncludes() {
    return List.generate(
        trip.priceIncludes.length,
        (index) => Row(
              children: [
                const Icon(
                  Icons.check,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  trip.priceIncludes[index],
                  style: const TextStyle(fontSize: 10),
                  softWrap: true,
                ),
              ],
            ));
  }

  buildPriceExclude() {
    return List.generate(
        trip.priceExcludes.length,
        (index) => Row(
              children: [
                const Icon(
                  Icons.clear,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(trip.priceExcludes[index],
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 10,
                      )),
                ),
              ],
            ));
  }

  buildCamping() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      const Text(
        "CAMPING",
        style: TextStyle(fontSize: 15),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        width: SizeConfig.screenWidth - 80,
        decoration: BoxDecoration(
            color: myPrimaryColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          trip.camping,
          style: const TextStyle(color: Colors.white),
        ),
      )
    ]);
  }

  buildItinerary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("Itinerary:"),
        ...List.generate(trip.itinerary.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myPrimaryColor),
                padding: const EdgeInsets.all(10),
                child: Text("day${index + 1}"),
              ),
              Container(
                  width: SizeConfig.screenWidth - 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: myPrimaryColor),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          trip.itinerary[index]["day${index + 1}"].length,
                          (index2) {
                        return Text(
                            trip.itinerary[index]["day${index + 1}"][index2]);
                      }))),
            ],
          );
        })
      ],
    );
  }

  buildFAQ() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
          child: Text("FAQ"),
        ),
        ...List.generate(trip.FAQ.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myPrimaryColor),
                child: Text(trip.FAQ[index]["question"]),
              ),
              Text(trip.FAQ[index]["answer"]),
            ],
          );
        })
      ],
    );
  }
}
