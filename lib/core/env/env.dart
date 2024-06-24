import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(
    varName: 'API_URL',
    defaultValue: 'https://api.openweathermap.org/data/2.5',
  )
  static const String apiUrl = _Env.apiUrl;

  @EnviedField(
      varName: 'API_KEY', defaultValue: '4e35228e32b036c2d59dd1c9fc87ca5d')
  static const String apiKey = _Env.apiKey;
}
