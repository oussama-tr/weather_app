// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/weather/domain/entities/weather_info.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather_info.dart';

part 'weather_info_event.dart';
part 'weather_info_state.dart';

/// BLoC (Business Logic Component) responsible for managing weather
/// information-related state and business logic.
///
/// This BLoC handles weather information-related events such as fetching
/// weather info for a city.
/// It coordinates with the use case [GetWeatherInfo] to perform these
/// operations and manages the state of the UI accordingly.
class WeatherInfoBloc extends Bloc<WeatherInfoEvent, WeatherInfoState> {
  final GetWeatherInfo getWeatherInfo;

  /// Constructs a [WeatherInfoBloc] instance with the necessary use case.
  ///
  /// [getWeatherInfo] is a dependency representing a use case for fetching
  /// weather information.
  WeatherInfoBloc({
    required this.getWeatherInfo,
  }) : super(WeatherInfoInitial()) {
    on<WeatherInfoEvent>((event, emit) async {
      if (event is GetCityWeatherInfo) {
        emit(WeatherInfoLoading());
        try {
          final failureOrWeatherInfo =
              await getWeatherInfo(GetWeatherInfoParams(city: event.city));
          emit(failureOrWeatherInfo.fold(
            (failure) => WeatherInfoError(message: failure.toString()),
            (weatherInfo) => WeatherInfoLoaded(weatherInfo: weatherInfo),
          ));
        } catch (e) {
          emit(WeatherInfoError(message: e.toString()));
        }
      }
    });
  }
}
