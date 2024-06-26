import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/dimensions.dart';
import 'package:weather_app/core/theme/weather_app_icons.dart';
import 'package:weather_app/core/theme/weather_app_palette.dart';

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({
    super.key,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  final double temp;
  final double tempMin;
  final double tempMax;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: WeatherAppPalette.cendre,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  WeatherAppIcons.getAssetPath(WeatherAppIcons.thermometer),
                  width: kIconSize,
                  height: kIconSize,
                ),
                const SizedBox(height: 10),
                Text('Temperature', style: textTheme.headlineMedium),
              ],
            ),
            Column(
              children: [
                Text('min $tempMin°C', style: textTheme.bodyMedium),
                const SizedBox(height: 10),
                Text('max $tempMax°C', style: textTheme.bodyMedium),
                const SizedBox(height: 10),
                Text('current $temp°C', style: textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
