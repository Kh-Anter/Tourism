import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tourism/models/region.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourism/models/trip.dart';

class HomeCtrl extends GetxController {
  List<Region> allRegions = [];
  List<Map<String, String>> places = [];
  List<Trip> allTrips = [];

  // read from firebase
  Future<List<Region>> fetchAllRegions() async {
    allRegions = [];
    var result = await FirebaseFirestore.instance.collection('Regions').get();
    for (var doc in result.docs) {
      allRegions.add(Region(
          name: doc["name"],
          img: doc["cover"],
          description: doc["description"],
          places: await fetchAllPlaces(doc["name"])));
    }
    return allRegions;
  }

  Future<List<Map<String, String>>> fetchAllPlaces(name) async {
    places = [];
    var result = await FirebaseFirestore.instance
        .collection('Regions/${name}/places')
        .get();
    for (var doc2 in result.docs) {
      places.add({"name": doc2["name"], "img": doc2["img"]});
    }
    return places;
  }

  Future<void> fetchAllTrips() async {
    allTrips = [];
    try {
      var result = await FirebaseFirestore.instance.collection('Trips').get();
      for (var doc in result.docs) {
        allTrips.add(Trip(
          name: doc["name"],
          age: doc["age"],
          count: doc["count"],
          cover: doc["cover"],
          salary: doc["salary"],
          duration: doc["duration"],
          weather: doc["Weather forecast"],
          availability: doc["Availability"],
          meetupPoint: doc["Meetup point"],
          camping: doc["CAMPING"],
          itinerary: doc["Itinerary"],
          priceIncludes: doc["Price includes"],
          priceExcludes: doc["Price excludes"],
          FAQ: doc["FAQ"],
        ));
      }
    } catch (e) {
      print("------ e $e");
    }
  }
}
