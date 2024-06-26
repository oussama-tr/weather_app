import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';

final kTestCity = City(name: 'Zocca', long: -1, lat: -1);
final kTWeatherInfoModel = WeatherInfoModel(
  main: 'Rain',
  description: 'moderate rain',
  temp: 288.32,
  feelsLike: 288.35,
  tempMin: 286.8,
  tempMax: 289.21,
  pressure: 1013,
  humidity: 94,
  windSpeed: 2.51,
  windDeg: 207,
  cloudsAll: 100,
  country: 'IT',
  cityName: kTestCity.name,
  sunrise: 1719286385,
  sunset: 1719342254,
  iconCode: '10n',
);
