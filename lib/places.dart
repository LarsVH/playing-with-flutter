import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

String api_key = 'AIzaSyAv4gvjtXinFQOf_v4qsjf2_ibvoUsAj7M';

Location _location = new Location();
Map<String,double> _currentlocation;


Future<Map<String,double>> getCurrentLocation() async {
  Map<String,double> location;
  
  try {
    location = await _location.getLocation;
  } on PlatformException {
    location = null;
  }
  _currentlocation = location;

  return location;

}


class Place {
  final String name;
  final double rating;
  final String address;

  Place.fromJson(Map jsonMap) :
  name = jsonMap['name'],
  rating = jsonMap['rating']?.toDouble() ?? -1.0,
  address = jsonMap['vicinity'];

  String toString() => 'Place: $name';
}

Future<Stream<Place>> getPlaces(double lat, double lng, String type) async {
  var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json' +
  '?location=$lat,$lng' +
  '&radius=500&type=$type' +
  '&key=$api_key';

  // http.get(url).then(
  //   (res) => print(res.body)
  //   );

  var client = new http.Client();
  var streamedRes = await client.send(
    new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
  .transform(UTF8.decoder)
  .transform(JSON.decoder)
  .expand((jsonbody) => (jsonbody as Map) ['results'])
  .map((jsonPlace) => new Place.fromJson(jsonPlace))
  .listen((data) => print(data))
  .onDone(() => client.close());
}


// Google places API key: AIzaSyAv4gvjtXinFQOf_v4qsjf2_ibvoUsAj7M 

