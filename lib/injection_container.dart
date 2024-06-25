import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/city/data/datasources/city_local_data_source.dart';
import 'package:weather_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';
import 'package:weather_app/features/city/domain/repositories/location_manager.dart';
import 'package:weather_app/features/city/data/repositories/location_provider.dart';
import 'package:weather_app/features/city/domain/usecases/add_city.dart';
import 'package:weather_app/features/city/domain/usecases/delete_city.dart';
import 'package:weather_app/features/city/domain/usecases/get_cities.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_info_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_info_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_info.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_info_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  /** Features - City **/
  // Bloc
  sl.registerFactory(() => CityBloc(
        getCities: sl(),
        addCity: sl(),
        deleteCity: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetCities(sl()));
  sl.registerLazySingleton(() => AddCity(sl()));
  sl.registerLazySingleton(() => DeleteCity(sl()));

  // Data sources
  sl.registerLazySingleton<CityLocalDataSource>(
    () => CityLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(
      localDataSource: sl(),
      locationManager: sl(),
    ),
  );

  /** Features - Weather **/
  // Bloc
  sl.registerFactory(() => WeatherInfoBloc(getWeatherInfo: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetWeatherInfo(sl()));

  // Repository
  sl.registerLazySingleton<WeatherInfoRepository>(
    () => WeatherInfoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherInfoRemoteDataSource>(
    () => WeatherInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<WeatherInfoLocalDataSource>(
    () => WeatherInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  /** External **/
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  /** Internal **/
  final locationProvider = LocationProvider();
  final locationManager = LocationManager(locationProvider);

  sl.registerLazySingleton(() => locationManager);

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );
}
