import 'dart:convert';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'weather_info_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late WeatherInfoRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = WeatherInfoRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('weather_info.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  final tCity = City(name: 'Zocca', long: -1, lat: -1);
  final tWeatherInfoModel = WeatherInfoModel.fromJson(
    json.decode(fixture('weather_info.json')) as Map<String, dynamic>,
  );

  test(
    'should perform a GET request on a URL with a city query and an application/json header',
    () {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getWeatherInfo(tCity);
      // assert
      verify(
        mockHttpClient.get(
          Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=${tCity.name}&appid=4e35228e32b036c2d59dd1c9fc87ca5d',
          ),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    },
  );

  test(
    'should return WeatherInfo when success code is 200',
    () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getWeatherInfo(tCity);
      // assert
      expect(result, equals(tWeatherInfoModel));
    },
  );

  test(
    'should throw ServerException when response code is not 200',
    () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getWeatherInfo;
      // assert
      expect(() => call(tCity), throwsA(isA<ServerException>()));
    },
  );
}
