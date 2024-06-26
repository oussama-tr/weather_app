import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/layout/weather_app_layout.dart';
import 'package:weather_app/core/theme/weather_app_icons.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_state.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_info_bloc.dart';
import 'package:weather_app/features/weather/presentation/widgets/day_cycle_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/icon_card_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/overview_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/temperature_widget.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WeatherAppLayout(
      appBarTitle: 'Weather details',
      child: SafeArea(
        child: BlocBuilder<CityBloc, CityState>(
          builder: (context, cityState) {
            if (cityState is CitiesLoaded && cityState.selectedCity != null) {
              // Dispatch an event to WeatherInfoBloc to fetch weather info
              context.read<WeatherInfoBloc>().add(
                    GetCityWeatherInfo(
                      city: City(name: cityState.selectedCity!.name),
                    ),
                  );
            }

            return BlocBuilder<WeatherInfoBloc, WeatherInfoState>(
              builder: (context, weatherState) {
                if (weatherState is WeatherInfoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (weatherState is WeatherInfoLoaded) {
                  final weatherInfo = weatherState.weatherInfo;

                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        OverviewWidget(
                          cityName: weatherInfo.cityName,
                          country: weatherInfo.country,
                          mainWeather: weatherInfo.main,
                          weatherDescription: weatherInfo.description,
                          feelsLike: weatherInfo.feelsLike,
                          cloudsCoverage: weatherInfo.cloudsAll,
                          iconCode: weatherInfo.iconCode,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: IconCardWidget(
                                icon: WeatherAppIcons.wind,
                                title: 'Wind',
                                data:
                                    'speed ${weatherInfo.windSpeed} km/h ${weatherInfo.windDeg}°',
                              ),
                            ),
                            Expanded(
                              child: IconCardWidget(
                                icon: WeatherAppIcons.barometer,
                                title: 'Pressure',
                                data: '${weatherInfo.pressure} hPa',
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        TemperatureWidget(
                          temp: weatherInfo.temp,
                          tempMin: weatherInfo.tempMin,
                          tempMax: weatherInfo.tempMax,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: IconCardWidget(
                                icon: WeatherAppIcons.humidity,
                                title: 'Humidity',
                                data: '${weatherInfo.humidity} g/kg',
                              ),
                            ),
                            Expanded(
                              child: DayCycleWidget(
                                sunrise: weatherInfo.sunrise,
                                sunset: weatherInfo.sunset,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (weatherState is WeatherInfoError) {
                  return Center(
                    child: Text('Error: ${weatherState.message}'),
                  );
                } else {
                  return const Center(
                    child: Text('No weather information available.'),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
