class Location {
  double latitude;
  double longitude;
  String geohash; // A geohash is created using a latitude and longitude

  Location(this.latitude, this.longitude, this.geohash);

  set setLatitude(double latitude) => this.latitude = latitude;
  set setLongitude(double longitude) => this.longitude = longitude;
  set setGeohash(String geohash) => this.geohash = geohash;

  get getLatitude => latitude;
  get getLongitude => longitude;
  get getGeohash => geohash;
}

var sampleLocations = [
  Location(51.5074, 0.1278, "e707"),
  Location(41.40338, 2.17403, "u907"),
  Location(38.8951, -77.0364, "r567"),
];
