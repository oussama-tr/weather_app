import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/dimensions.dart';
import 'package:weather_app/core/theme/weather_app_icons.dart';
import 'package:weather_app/core/theme/weather_app_palette.dart';

class IconCardWidget extends StatelessWidget {
  const IconCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
  });

  final WeatherAppIcons icon;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: WeatherAppPalette.cendre,
      child: Container(
        height: kIconCardHeight,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              WeatherAppIcons.getAssetPath(icon),
              width: kIconSize,
              height: kIconSize,
            ),
            Text(title, style: textTheme.headlineMedium),
            Text(data, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
