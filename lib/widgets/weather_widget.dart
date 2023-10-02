import 'package:flutter/material.dart';
import 'package:flutter_app/models/weather/weather_model.dart';
import 'package:flutter_app/utils/custom_colors.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherCurrent weatherData;
  const WeatherWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tempAreaWidget(),
        const SizedBox(
          height: 30,
        ),
        getCurrentWeatherMoreDetailsWidget(),
      ],
    );
    // Container(
    //   child: Text('${weatherData.weather?[0].description}'),
    // );
  }

  Widget getCurrentWeatherMoreDetailsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/humidity.png"),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 20,
              width: 60,
              child: Text(
                "${weatherData.wind}km/h",
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 20,
              width: 60,
              child: Text(
                "${weatherData.clouds}%",
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 20,
              width: 60,
              child: Text(
                "${weatherData.humi}%",
                style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget tempAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherData.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
                text: "${weatherData.temp!.toInt()}°C",
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 60,
                    color: Colors.white60)),
            TextSpan(
                text: "${weatherData.weather![0].description}",
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white38))
          ],
        ))
      ],
    );
  }
}
