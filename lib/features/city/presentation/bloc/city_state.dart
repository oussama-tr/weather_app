import 'package:equatable/equatable.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';

/// Abstract base class for all states related to city data in the application.
abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

/// Initial state.
class CityInitial extends CityState {}

/// State representing that city data is currently being loaded.
class CitiesLoading extends CityState {}

/// State representing that city data has been successfully loaded.
///
/// [cities] is the list of cities loaded from the data source.
/// [selectedCity] is the currently selected city, if any.
class CitiesLoaded extends CityState {
  final List<City> cities;
  final City? selectedCity;

  const CitiesLoaded(this.cities, this.selectedCity);

  @override
  List<Object?> get props => [cities, selectedCity];
}

/// State representing a failure in performing an operation related to city data.
///
/// [message] provides a descriptive error message for the failure.
class CityOperationFailure extends CityState {
  final String message;

  const CityOperationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
