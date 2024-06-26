import 'dart:convert';

import 'package:weather_app/features/city/domain/entities/city.dart';

/// Data model for a city, extending the [City] entity.
///
/// This class includes methods to serialize and deserialize city data
/// to and from JSON format, enabling easy storage and retrieval.
class CityModel extends City {
  /// Creates a [CityModel] instance with the given [name], [long] and [lat].
  CityModel({
    required super.name,
    required super.long,
    required super.lat,
    super.isCurrentCity,
  });

  /// Creates a [CityModel] instance from a JSON object.
  ///
  /// The [json] parameter is a map containing the city data in JSON format.
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      long: json['long'],
      lat: json['lat'],
      isCurrentCity: json['isCurrentCity'],
    );
  }

  /// Converts this [CityModel] instance to a JSON object.
  ///
  /// Returns a map containing the city data in JSON format.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'long': long,
      'lat': lat,
      'isCurrentCity': isCurrentCity,
    };
  }

  /// Creates a list of [CityModel] instances from a list of JSON-encoded strings.
  ///
  /// The [jsonList] parameter is a list of strings where each string represents
  /// JSON-encoded city data.
  ///
  /// Returns a list of [CityModel] instances parsed from the JSON strings.
  static List<CityModel> fromJsonList(List<String> jsonList) {
    return jsonList
        .map((jsonString) =>
            CityModel.fromJson(jsonDecode(jsonString) as Map<String, dynamic>))
        .toList();
  }

  /// Converts a list of [CityModel] instances into a list of JSON-encoded strings.
  ///
  /// Converts each [CityModel] in [cityList] into a JSON-encoded string using
  /// its [toJson] method.
  ///
  /// Returns a list of strings where each string represents JSON-encoded city data.
  static List<String> toJsonList(List<CityModel> cityList) {
    return cityList.map((city) => jsonEncode(city.toJson())).toList();
  }
}
