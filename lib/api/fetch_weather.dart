import 'dart:convert';

import 'package:flutter_app/api/api_key.dart';

import 'package:flutter_app/models/weather/weather_model.dart';

import 'package:http/http.dart' as http;

Future<WeatherCurrent> fetchWeatherAPI(lat, lon) async {
  final res = await http.get(Uri.parse(apiURL(lat, lon)));
  //var jsonString = jsonDecode(res.body);
  //weatherData = WeatherData(Weather.fromJson(res.body));
  //if (res.statusCode == 200) {
  // If the server did return a 200 OK response,
  // then parse the JSON.
  //return res.body.toString();

  return WeatherCurrent.fromJson(jsonDecode(res.body));
//} else {
  // If the server did not return a 200 OK response,
  // then throw an exception.
  //  throw Exception('Failed to load album');
  //}
}

String apiURL(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
  return url;
}
