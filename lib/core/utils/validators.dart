String? validateCityName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a city name';
  }
  return null;
}

String? validateLongitude(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter longitude';
  }
  final double? longitude = double.tryParse(value);
  if (longitude == null || longitude < -180 || longitude > 180) {
    return 'Please enter a valid longitude';
  }
  return null;
}

String? validateLatitude(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter latitude';
  }
  final double? latitude = double.tryParse(value);
  if (latitude == null || latitude < -90 || latitude > 90) {
    return 'Please enter a valid latitude';
  }
  return null;
}
