import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_info_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_info.dart';

import 'get_weather_info_test.mocks.dart';

@GenerateMocks([WeatherInfoRepository])
void main() {
  final tCity = City(name: 'Zocca', long: -1, lat: -1);
  final tWeatherInfoModel = WeatherInfoModel(
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
    cityName: tCity.name,
    sunrise: 1719286385,
    sunset: 1719342254,
    iconCode: '10n',
  );
  final mockWeatherInfoRepository = MockWeatherInfoRepository();
  final usecase = GetWeatherInfo(mockWeatherInfoRepository);
  test('should get weather info for the city from the repository', () async {
    // arrange
    when(mockWeatherInfoRepository.getWeatherInfo(any))
        .thenAnswer((_) async => Right(tWeatherInfoModel));
    // act
    final result = await usecase(GetWeatherInfoParams(city: tCity));
    // assert
    expect(result, Right(tWeatherInfoModel));
    verify(mockWeatherInfoRepository.getWeatherInfo(tCity));
    verifyNoMoreInteractions(mockWeatherInfoRepository);
  });
}
