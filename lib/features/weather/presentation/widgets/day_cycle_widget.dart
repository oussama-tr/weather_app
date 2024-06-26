import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/dimensions.dart';
import 'package:weather_app/core/theme/weather_app_icons.dart';
import 'package:weather_app/core/theme/weather_app_palette.dart';

class DayCycleWidget extends StatelessWidget {
  const DayCycleWidget({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

  final int sunrise;
  final int sunset;

  String _getFormattedTimestamp(int unixTimestamp) {
    // Convert Unix timestamp to DateTime
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

    // Format the DateTime object to a readable time
    return DateFormat('HH:mm a').format(dateTime);
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  WeatherAppIcons.getAssetPath(WeatherAppIcons.day),
                  width: kIconSize,
                  height: kIconSize,
                ),
                Text(
                  _getFormattedTimestamp(sunrise),
                  style: textTheme.headlineMedium,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  WeatherAppIcons.getAssetPath(WeatherAppIcons.night),
                  width: 60,
                  height: 60,
                ),
                Text(
                  _getFormattedTimestamp(sunset),
                  style: textTheme.headlineMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
