import 'package:weather_app/features/city/domain/entities/city.dart';

/// Data model for a city, extending the [City] entity.
///
/// This class includes methods to serialize and deserialize city data
/// to and from JSON format, enabling easy storage and retrieval.
class CityModel extends City {
  /// Creates a [CityModel] instance with the given [name].
  CityModel({required super.name});

  /// Creates a [CityModel] instance from a JSON object.
  ///
  /// The [json] parameter is a map containing the city data in JSON format.
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(name: json['name']);
  }

  /// Converts this [CityModel] instance to a JSON object.
  ///
  /// Returns a map containing the city data in JSON format.
  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  /// Creates a list of [CityModel] instances from a list of JSON strings.
  ///
  /// The [jsonList] parameter is a list of strings containing city data.
  /// Returns a list of [CityModel] instances.
  static List<CityModel> fromJsonList(List<String> jsonList) {
    return jsonList.map((json) => CityModel(name: json)).toList();
  }

  /// Converts a list of [CityModel] instances to a list of JSON strings.
  ///
  /// The [cityList] parameter is a list of [CityModel] instances.
  /// Returns a list of strings containing city data.
  static List<String> toJsonList(List<CityModel> cityList) {
    return cityList.map((city) => city.name).toList();
  }
}
