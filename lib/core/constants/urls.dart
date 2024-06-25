import 'package:weather_app/core/env/env.dart';

class Urls {
  static String currentWeatherByName(String city) =>
      '${Env.apiUrl}/weather?q=$city&appid=${Env.apiKey}';
}
