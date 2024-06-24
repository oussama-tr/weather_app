import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_info_bloc.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_details_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<CityBloc>()..add(LoadCities()),
        ),
        BlocProvider(create: (context) => di.sl<WeatherInfoBloc>())
      ],
      child: const MaterialApp(
        home: WeatherDetailsPage(),
      ),
    );
  }
}
