import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_event.dart';
import 'package:weather_app/features/city/presentation/bloc/city_state.dart';

class AddCityPage extends StatelessWidget {
  const AddCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add city dummy screen'),
      ),
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          return SafeArea(
            child: _buildAddCitySection(context),
          );
        },
      ),
    );
  }

  Widget _buildAddCitySection(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: cityController,
            decoration: const InputDecoration(hintText: 'City name'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<CityBloc>(context).add(
                AddCityEvent(
                  City(
                    name: cityController.text,
                  ),
                ),
              );

              Navigator.of(context).pop();
            },
            child: const Text('Add City'),
          ),
        ],
      ),
    );
  }
}
