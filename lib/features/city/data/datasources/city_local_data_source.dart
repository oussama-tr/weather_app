import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/city/data/models/city_model.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';

/// Abstract class defining local data source operations for city data.
///
/// This class outlines methods for interacting with city data at a local
/// data source level, such as getting cities, saving, adding, deleting and
/// selecting a city.
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

  /// Retrieves the currently selected city from the local data source.
  ///
  /// Returns a [Future] that completes with the currently selected [City],
  /// or `null` if no city is currently selected.
  Future<City?> getSelectedCity();

  /// Sets the currently selected city in the local data source.
  ///
  /// [city] is the city to be set as the currently selected city.
  /// Returns a [Future] that completes when the operation finishes.
  Future<void> setSelectedCity(City city);
}

/// Implementation of [CityLocalDataSource] using [SharedPreferences] for local data storage.
///
/// This class provides methods to interact with city data stored in [SharedPreferences].
class CityLocalDataSourceImpl implements CityLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String _citiesKey = 'CITIES_KEY';
  final String _selectedCityKey = 'SELECTED_CITY_KEY';

  /// Constructs a [CityLocalDataSourceImpl] instance with the given [sharedPreferences].
  CityLocalDataSourceImpl({required this.sharedPreferences});

  Future<void> _saveCities(List<City> cities) async {
    final normalizedCities =
        cities.map((city) => city.name.toLowerCase()).toList();
    final jsonList = CityModel.toJsonList(
        normalizedCities.map((name) => CityModel(name: name)).toList());
    await sharedPreferences.setStringList(_citiesKey, jsonList);
  }

  @override
  Future<List<City>> getCities() async {
    final jsonList = sharedPreferences.getStringList(_citiesKey) ?? [];
    final cityModels = CityModel.fromJsonList(jsonList);
    return cityModels;
  }

  @override
  Future<void> addCity(City city) async {
    final cities = await getCities();
    final normalizedCityName = city.name.toLowerCase();

    if (!cities.any((c) => c.name.toLowerCase() == normalizedCityName)) {
      cities.add(CityModel(name: normalizedCityName));
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

  @override
  Future<City?> getSelectedCity() async {
    final cityName = sharedPreferences.getString(_selectedCityKey);
    return cityName != null ? City(name: cityName) : null;
  }

  @override
  Future<void> setSelectedCity(City city) async {
    await sharedPreferences.setString(_selectedCityKey, city.name);
  }
}
