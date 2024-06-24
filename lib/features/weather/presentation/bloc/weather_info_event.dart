part of 'weather_info_bloc.dart';

/// Abstract base class for all events related to weather information
/// in the application.
abstract class WeatherInfoEvent extends Equatable {
  const WeatherInfoEvent();

  @override
  List<Object> get props => [];
}

/// Event indicating a request to fetch weather information for a specific city.
class GetWeatherInfo extends WeatherInfoEvent {
  final String city;

  const GetWeatherInfo({required this.city});

  @override
  List<Object> get props => [city];
}
