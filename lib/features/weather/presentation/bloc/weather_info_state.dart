part of 'weather_info_bloc.dart';

/// Abstract base class for all states related to weather information in
/// the application.
abstract class WeatherInfoState extends Equatable {
  const WeatherInfoState();

  @override
  List<Object> get props => [];
}

/// Initial state for weather information.
class WeatherInfoInitial extends WeatherInfoState {}

/// State representing that weather information is currently being loaded.
class WeatherInfoLoading extends WeatherInfoState {}

/// State representing that weather information has been successfully loaded.
///
/// [weatherInfo] contains the weather information loaded from the data source.
class WeatherInfoLoaded extends WeatherInfoState {
  final WeatherInfo weatherInfo;

  const WeatherInfoLoaded({required this.weatherInfo});

  @override
  List<Object> get props => [weatherInfo];
}

/// State representing an error in loading weather information.
///
/// [message] provides a descriptive error message for the failure.
class WeatherInfoError extends WeatherInfoState {
  final String message;

  const WeatherInfoError({required this.message});

  @override
  List<Object> get props => [message];
}
