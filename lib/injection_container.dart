import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/city/data/datasources/city_local_data_source.dart';
import 'package:weather_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:weather_app/features/city/domain/repositories/city_repository.dart';
import 'package:weather_app/features/city/domain/usecases/add_city.dart';
import 'package:weather_app/features/city/domain/usecases/delete_city.dart';
import 'package:weather_app/features/city/domain/usecases/get_cities.dart';
import 'package:weather_app/features/city/domain/usecases/get_selected_city.dart';
import 'package:weather_app/features/city/domain/usecases/set_selected_city.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/weather/data/datasources/weather_info_remote_datasource.dart';
import 'package:weather_app/features/weather/data/repositories/weather_info_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_info_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_info.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_info_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /** Features - City **/
  // Bloc
  sl.registerFactory(() => CityBloc(
        getCities: sl(),
        addCity: sl(),
        deleteCity: sl(),
        getSelectedCity: sl(),
        setSelectedCity: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetCities(sl()));
  sl.registerLazySingleton(() => AddCity(sl()));
  sl.registerLazySingleton(() => DeleteCity(sl()));
  sl.registerLazySingleton(() => GetSelectedCity(sl()));
  sl.registerLazySingleton(() => SetSelectedCity(sl()));

  // Data sources
  sl.registerLazySingleton<CityLocalDataSource>(
    () => CityLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(localDataSource: sl()),
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
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherInfoRemoteDataSource>(
    () => WeatherInfoRemoteDataSourceImpl(client: sl()),
  );

  ///  External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
