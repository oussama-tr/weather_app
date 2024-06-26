/// An enum that that provides the icons used across the application.
enum WeatherAppIcons {
  thermometer('thermometer', IconType.png),
  wind('wind', IconType.png),
  barometer('barometer', IconType.png),
  humidity('humidity', IconType.png),
  day('day', IconType.svg),
  night('night', IconType.svg);

  const WeatherAppIcons(this.name, this.type);

  final String name;
  final IconType type;

  static String getAssetPath(WeatherAppIcons asset) {
    switch (asset.type) {
      case IconType.png:
        return 'assets/png/icon_${asset.name}.png';
      case IconType.svg:
        return 'assets/svg/icon_${asset.name}.svg';
    }
  }
}

enum IconType { png, svg }
