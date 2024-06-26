import 'package:weather_app/core/env/env.dart';

class Urls {
  static String currentWeatherByName(String city) =>
      '${Env.apiUrl}/weather?q=$city&appid=${Env.apiKey}';
  static String currentWeatherByCoordinates(double long, double lat) =>
      '${Env.apiUrl}/weather?lat=$long&lon=$long&appid=${Env.apiKey}';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
