import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_info_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_info.dart';

import '../../../../constants.dart';
import 'get_weather_info_test.mocks.dart';

@GenerateMocks([WeatherInfoRepository])
void main() {
  final mockWeatherInfoRepository = MockWeatherInfoRepository();
  final usecase = GetWeatherInfo(mockWeatherInfoRepository);
  test('should get weather info for the city from the repository', () async {
    // arrange
    when(mockWeatherInfoRepository.getWeatherInfo(any))
        .thenAnswer((_) async => Right(kTWeatherInfoModel));
    // act
    final result = await usecase(GetWeatherInfoParams(city: kTestCity));
    // assert
    expect(result, Right(kTWeatherInfoModel));
    verify(mockWeatherInfoRepository.getWeatherInfo(kTestCity));
    verifyNoMoreInteractions(mockWeatherInfoRepository);
  });
}
