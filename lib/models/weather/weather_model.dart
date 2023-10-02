import 'package:flutter_app/models/weather/weather.dart';

class WeatherCurrent {
  String? cityName;
  double? temp;
  double? wind;
  int? humi;
  double? feels_like;
  int? pressure;
  List<Weather>? weather;
  int? clouds;
  WeatherCurrent(
      {this.cityName,
      this.feels_like,
      this.humi,
      this.pressure,
      this.temp,
      this.wind,
      this.clouds});

  WeatherCurrent.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    humi = json["main"]["humidity"];
    pressure = json["main"]["pressure"];
    feels_like = json["main"]["feels_like"];
    clouds = json["clouds"]["all"];
    weather = (json['weather'] as List<dynamic>)
        .map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
