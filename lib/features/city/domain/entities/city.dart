class City {
  final String name;
  final double long;
  final double lat;
  final bool isCurrentCity;

  /// Creates a [City] instance with the given [name], [long], [lat]
  /// and [isCurrentCity].
  City({
    required this.name,
    required this.long,
    required this.lat,
    this.isCurrentCity = false,
  });
}
