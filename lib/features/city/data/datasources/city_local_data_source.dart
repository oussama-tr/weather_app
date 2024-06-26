import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/city/data/models/city_model.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';

/// Abstract class defining local data source operations for city data.
///
/// This class outlines methods for interacting with city data at a local
/// data source level, such as getting cities, saving, adding and deleting
/// a city.
abstract class CityLocalDataSource {
  /// Retrieves a list of cities from the local data source.
  ///
  /// Returns a [Future] that completes with a list of [City] instances.
  Future<List<City>> getCities();

  /// Adds a new city to the local data source.
  ///
  /// [city] is the city to be added.
  /// Returns a [Future] that completes when the operation finishes.
  Future<void> addCity(City city);

  /// Deletes a city from the local data source.
  ///
  /// [city] is the city to be deleted.
  /// Returns a [Future] that completes when the operation finishes.
  Future<void> deleteCity(City city);
}

/// Implementation of [CityLocalDataSource] using [SharedPreferences] for local data storage.
///
/// This class provides methods to interact with city data stored in [SharedPreferences].
class CityLocalDataSourceImpl implements CityLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String _citiesKey = 'CITIES_KEY';

  /// Constructs a [CityLocalDataSourceImpl] instance with the given [sharedPreferences].
  CityLocalDataSourceImpl({required this.sharedPreferences});

  Future<void> _saveCities(List<City> cities) async {
    final jsonList = CityModel.toJsonList(cities
        .map(
          (city) => CityModel(
            name: city.name,
            long: city.long,
            lat: city.lat,
            isCurrentCity: city.isCurrentCity,
          ),
        )
        .toList());

    await sharedPreferences.setStringList(_citiesKey, jsonList);
  }

  @override
  Future<List<City>> getCities() async {
    final jsonStringList = sharedPreferences.getStringList(_citiesKey) ?? [];
    final cityModels = CityModel.fromJsonList(jsonStringList);

    return cityModels;
  }

  @override
  Future<void> addCity(City city) async {
    final cities = await getCities();
    final normalizedCityName = city.name.toLowerCase();

    if (!cities.any((c) => c.name.toLowerCase() == normalizedCityName) &&
        city.name.isNotEmpty) {
      cities.add(
        CityModel(
          name: city.name,
          long: city.long,
          lat: city.lat,
          isCurrentCity: city.isCurrentCity,
        ),
      );

      await _saveCities(cities);
    }
  }

  @override
  Future<void> deleteCity(City city) async {
    final cities = await getCities();
    final normalizedCityName = city.name.toLowerCase();

    cities.removeWhere((c) => c.name.toLowerCase() == normalizedCityName);

    await _saveCities(cities);
  }
}
