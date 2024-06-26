import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/urls.dart';
import 'package:weather_app/core/theme/weather_app_palette.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({
    super.key,
    required this.cityName,
    required this.country,
    required this.mainWeather,
    required this.weatherDescription,
    required this.feelsLike,
    required this.cloudsCoverage,
    required this.iconCode,
  });

  final String cityName;
  final String country;
  final String mainWeather;
  final String weatherDescription;
  final double feelsLike;
  final int cloudsCoverage;
  final String iconCode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: WeatherAppPalette.cendre,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Text(
              '$cityName, $country',
              style: textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Feels like $feelsLike°C',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mainWeather,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      weatherDescription,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image(
                      image: NetworkImage(
                        Urls.weatherIcon(iconCode),
                      ),
                    ),
                    Text(
                      'Clouds coverage: $cloudsCoverage%',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
