import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_routes.dart';
import 'package:weather_app/core/layout/weather_app_layout.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_event.dart';
import 'package:weather_app/features/city/presentation/bloc/city_state.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WeatherAppLayout(
      appBarTitle: "Cities",
      child: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          return SafeArea(
            child: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, CityState state) {
    if (state is CitiesLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CitiesLoaded) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCitiesList(state.cities),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.addCity),
              child: Text(
                'Add City',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      );
    } else if (state is CityOperationFailure) {
      return Center(
        child: Text('Operation Failed: ${state.message}'),
      );
    } else {
      return const Center(
        child: Text('Unknown State'),
      );
    }
  }

  Widget _buildCitiesList(List<City> cities) {
    return Expanded(
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return GestureDetector(
            onTap: () {
              BlocProvider.of<CityBloc>(context).add(
                SelectCityEvent(city),
              );

              Navigator.of(context).pushNamed(AppRoutes.weatherDetails);
            },
            child: ListTile(
              title: Text(
                city.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              trailing: Visibility(
                visible: !city.isCurrentCity,
                child: IconButton(
                  icon: const Icon(Icons.delete_sharp),
                  color: Colors.white,
                  onPressed: () {
                    BlocProvider.of<CityBloc>(context).add(
                      DeleteCityEvent(city),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
