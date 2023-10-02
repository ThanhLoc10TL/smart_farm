import 'dart:convert';

import 'package:flutter_app/models/weather/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<WeatherCurrent> getCurrentWeather(double? lat, double? lon) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=1bfcdde8752cf01d30d13d3d399a3738&units=metric");
    var res = await http.get(endpoint);
    print(WeatherCurrent.fromJson(jsonDecode(res.body)).cityName);
    return WeatherCurrent.fromJson(jsonDecode(res.body));
  }
}
