import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_routes.dart';
import 'package:weather_app/features/city/presentation/bloc/city_bloc.dart';
import 'package:weather_app/features/city/presentation/bloc/city_event.dart';
import 'package:weather_app/features/city/presentation/pages/add_city_page.dart';
import 'package:weather_app/features/city/presentation/pages/cities_page.dart';
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
      child: MaterialApp(
        initialRoute: AppRoutes.cities,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.cities:
              return MaterialPageRoute(
                builder: (_) => const CitiesPage(),
              );
            case AppRoutes.addCity:
              return MaterialPageRoute(
                builder: (_) => const AddCityPage(),
              );
            case AppRoutes.weatherDetails:
              return MaterialPageRoute(
                builder: (_) => const WeatherDetailsPage(),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
