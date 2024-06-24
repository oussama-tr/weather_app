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
        title: const Text('Weather details dummy screen'),
      ),
      body: SafeArea(
        child: BlocListener<CityBloc, CityState>(
          listener: (context, state) {
            if (state is CitiesLoaded && state.selectedCity != null) {
              context.read<WeatherInfoBloc>().add(
                    GetCityWeatherInfo(
                      city: City(name: state.selectedCity!.name),
                    ),
                  );
            }
          },
          child: BlocBuilder<WeatherInfoBloc, WeatherInfoState>(
            builder: (context, state) {
              if (state is WeatherInfoLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherInfoLoaded) {
                return Center(
                  child: Text(
                    state.weatherInfo.toString(),
                  ),
                );
              } else if (state is WeatherInfoError) {
                return Center(
                  child: Text('Error: ${state.message}'),
                );
              } else {
                return const Center(
                  child: Text('No weather information available.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
