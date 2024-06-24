import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_remote_datasource.dart';
import 'package:weather_app/features/weather/domain/entities/weather_info.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_info_repository.dart';

/// Implementation of the [WeatherInfoRepository] interface for managing weather
/// information.
///
/// This class interacts with a remote data source to fetch weather information
/// and handles any errors that might occur during the process.
class WeatherInfoRepositoryImpl implements WeatherInfoRepository {
  final WeatherInfoRemoteDataSource remoteDataSource;

  /// Constructs a [WeatherInfoRepositoryImpl] instance with the given
  /// [remoteDataSource].
  WeatherInfoRepositoryImpl({
    required this.remoteDataSource,
  });

  /// Retrieves weather information for the given [city] by calling the remote
  /// data source.
  ///
  /// Returns an [Either] containing either a [Failure] or a [WeatherInfo]
  /// instance. If a [ServerException] occurs, a [ServerFailure] is returned.
  @override
  Future<Either<Failure, WeatherInfo>> getWeatherInfo(City city) async {
    try {
      final remoteInfo = await remoteDataSource.getWeatherInfo(city);
      return Right(remoteInfo);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
