import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_info_repository_impl.dart';
import '../../../../constants.dart';
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
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(kTestCity))
            .thenAnswer((_) async => kTWeatherInfoModel);
        // act
        await repository.getWeatherInfo(kTestCity);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(kTestCity))
            .thenAnswer((_) async => kTWeatherInfoModel);
        // act
        final result = await repository.getWeatherInfo(kTestCity);
        // assert
        verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(kTestCity));
        expect(result, equals(Right(kTWeatherInfoModel)));
      },
    );

    test(
      'should cache the data locally when the call to remote data source is successful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(kTestCity))
            .thenAnswer((_) async => kTWeatherInfoModel);
        // act
        await repository.getWeatherInfo(kTestCity);
        // assert
        verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(kTestCity));
        verify(mockWeatherInfoLocalDataSource.cacheWeatherInfo(
          kTWeatherInfoModel.cityName,
          kTWeatherInfoModel,
        ));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockWeatherInfoRemoteDataSource.getWeatherInfo(kTestCity))
            .thenThrow(ServerException('Server Error'));
        // act
        final result = await repository.getWeatherInfo(kTestCity);
        // assert
        verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(kTestCity));
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
        when(mockWeatherInfoLocalDataSource
                .getCachedWeatherInfo(kTestCity.name))
            .thenAnswer((_) async => kTWeatherInfoModel);
        // act
        final result = await repository.getWeatherInfo(kTestCity);
        // assert
        verifyZeroInteractions(mockWeatherInfoRemoteDataSource);
        verify(mockWeatherInfoLocalDataSource
            .getCachedWeatherInfo(kTestCity.name));
        expect(result, equals(Right(kTWeatherInfoModel)));
      },
    );

    test(
      'should return CacheFailure when the cached data is not present',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockWeatherInfoLocalDataSource
                .getCachedWeatherInfo(kTestCity.name))
            .thenThrow(CacheException('Cache Error'));
        // act
        final result = await repository.getWeatherInfo(kTestCity);
        // assert
        verifyZeroInteractions(mockWeatherInfoRemoteDataSource);
        verify(mockWeatherInfoLocalDataSource
            .getCachedWeatherInfo(kTestCity.name));
        expect(result, equals(const Left(CacheFailure())));
      },
    );
  });
}
