import 'package:equatable/equatable.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';

/// Abstract base class for all events related to city operations in the application.
abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object?> get props => [];
}

/// Event indicating a request to load cities.
class LoadCities extends CityEvent {}

/// Event indicating a request to add a new city.
///
/// [city] is the city to be added.
class AddCityEvent extends CityEvent {
  final City city;

  const AddCityEvent(this.city);

  @override
  List<Object?> get props => [city];
}

/// Event indicating a request to delete an existing city.
///
/// [city] is the city to be deleted.
class DeleteCityEvent extends CityEvent {
  final City city;

  const DeleteCityEvent(this.city);

  @override
  List<Object?> get props => [city];
}

/// Event indicating a request to select a city.
///
/// [city] is the city to be selected.
class SelectCityEvent extends CityEvent {
  final City city;

  const SelectCityEvent(this.city);

  @override
  List<Object?> get props => [city];
}
