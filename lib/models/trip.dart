class Trip {
  String? cover, name, duration, availability, weather, meetupPoint, camping;
  int? age, count, salary;
  List? priceIncludes, priceExcludes;
  var itinerary;
  List? FAQ;
  Trip(
      {this.cover,
      this.name,
      this.duration,
      this.availability,
      this.weather,
      this.meetupPoint,
      this.camping,
      this.age,
      this.count,
      this.salary,
      this.priceIncludes,
      this.priceExcludes,
      this.itinerary,
      this.FAQ});
}
