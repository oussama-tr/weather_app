import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_info_model.dart';
import 'package:weather_app/features/weather/data/repositories/weather_info_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_info.dart';
import 'weather_info_repository_impl_test.mocks.dart';

@GenerateMocks([
  WeatherInfoRemoteDataSource,
  WeatherInfoLocalDataSource,
  NetworkInfo,
])
void main() {
  late MockWeatherInfoLocalDataSource mockWeatherInfoLocalDataSource;
  late MockWeatherInfoRemoteDataSource mockWeatherInfoRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late WeatherInfoRepositoryImpl repository;

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
  final WeatherInfo tWeatherInfo = tWeatherInfoModel;

  setUp(() {
    mockWeatherInfoLocalDataSource = MockWeatherInfoLocalDataSource();
    mockWeatherInfoRemoteDataSource = MockWeatherInfoRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherInfoRepositoryImpl(
      localDataSource: mockWeatherInfoLocalDataSource,
      remoteDataSource: mockWeatherInfoRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('device is online', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity))
            .thenAnswer((_) async => tWeatherInfoModel);
        // act
        await repository.getWeatherInfo(tCity);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity))
            .thenAnswer((_) async => tWeatherInfoModel);
        // act
        final result = await repository.getWeatherInfo(tCity);
        // assert
        verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity));
        expect(result, equals(Right(tWeatherInfo)));
      },
    );

    test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity))
            .thenAnswer((_) async => tWeatherInfoModel);
        // act
        await repository.getWeatherInfo(tCity);
        // assert
        verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity));
        verify(mockWeatherInfoLocalDataSource.cacheWeatherInfo(
          tWeatherInfoModel.cityName,
          tWeatherInfoModel,
        ));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity))
            .thenThrow(ServerException('Server Error'));
        // act
        final result = await repository.getWeatherInfo(tCity);
        // assert
        verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity));
        verifyZeroInteractions(mockWeatherInfoLocalDataSource);
        expect(result, equals(const Left(ServerFailure())));
      },
    );
  });

  group('device is offline', () {
    test(
      'should return last locally cached data when the cached data is present',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockWeatherInfoLocalDataSource.getCachedWeatherInfo(tCity.name))
            .thenAnswer((_) async => tWeatherInfoModel);
        // act
        final result = await repository.getWeatherInfo(tCity);
        // assert
        verifyZeroInteractions(mockWeatherInfoRemoteDataSource);
        verify(mockWeatherInfoLocalDataSource.getCachedWeatherInfo(tCity.name));
        expect(result, equals(Right(tWeatherInfo)));
      },
    );

    test(
      'should return CacheFailure when the cached data is not present',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockWeatherInfoLocalDataSource.getCachedWeatherInfo(tCity.name))
            .thenThrow(CacheException('Cache Error'));
        // act
        final result = await repository.getWeatherInfo(tCity);
        // assert
        verifyZeroInteractions(mockWeatherInfoRemoteDataSource);
        verify(mockWeatherInfoLocalDataSource.getCachedWeatherInfo(tCity.name));
        expect(result, equals(const Left(CacheFailure())));
      },
    );
  });
}
