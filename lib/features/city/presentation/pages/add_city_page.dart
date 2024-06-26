import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/layout/weather_app_layout.dart';
import 'package:weather_app/core/utils/validators.dart';
import 'package:weather_app/core/widgets/text_field_widget.dart';
import 'package:weather_app/features/city/domain/entities/city.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_event.dart';
import 'package:weather_app/features/city/presentation/bloc/city_state.dart';

class AddCityPage extends StatefulWidget {
  const AddCityPage({super.key});

  @override
  AddCityPageState createState() => AddCityPageState();
}

class AddCityPageState extends State<AddCityPage> {
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cityNameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _addCity(BuildContext context) {
    BlocProvider.of<CityBloc>(context).add(
      AddCityEvent(
        City(
          name: _cityNameController.text,
          long: double.parse(_longitudeController.text),
          lat: double.parse(_latitudeController.text),
        ),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WeatherAppLayout(
      appBarTitle: 'Add a city',
      child: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          return SafeArea(
            child: _buildBody(context),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldWidget(
              controller: _cityNameController,
              hintText: 'City name',
              validator: validateCityName,
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              controller: _longitudeController,
              hintText: 'Longitude',
              validator: validateLongitude,
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              controller: _latitudeController,
              hintText: 'Latitude',
              validator: validateLatitude,
            ),
            const SizedBox(height: 40),
            BlocBuilder<CityBloc, CityState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _addCity(context);
                    }
                  },
                  child: Text(
                    'Confirm',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
