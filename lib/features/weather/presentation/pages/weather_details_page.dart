import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_state.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_info_bloc.dart';

class WeatherDetailsPage extends StatelessWidget {
  const WeatherDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: SafeArea(
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
                  return Center(
                    child: Text(
                      weatherState.weatherInfo.toString(),
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
