part of 'weather_info_bloc.dart';

/// Abstract base class for all events related to weather information
/// in the application.
abstract class WeatherInfoEvent extends Equatable {
  const WeatherInfoEvent();

  @override
  List<Object> get props => [];
}

/// Event indicating a request to fetch weather information for a specific city.
class GetCityWeatherInfo extends WeatherInfoEvent {
  final City city;

  const GetCityWeatherInfo({required this.city});

  @override
  List<Object> get props => [city];
}
