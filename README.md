# Weather App

<img width="250px" src="https://github.com/oussama-tr/weather_app/assets/69165378/fc25ebc7-7c54-4ae0-a8d9-d5a81e3e36bb">

## Getting started

### Install project dependencies

To install project dependencies, you can run the following command before running the build command :

```bash
flutter pub get
```

#### Environment variable

We're using [envied](https://pub.dev/packages/envied) for managing our environment variables

You need to set them up in an **.env** file, you can copy the **.env.example** and modify the values.

```bash
cp .env.example .env
```

### Build generated files

Before running the application you need to build generated files, to do so you can run the following commands:

```bash
flutter pub run build_runner clean
dart run build_runner build -d
```

### Run the application

To run the application, you can run the following command:

```bash
flutter run -t lib/main.dart
```

### Analyze the application

To analyze the application, you can run the following command:

```bash
flutter analyze
```

### Test the application

To test the application framework you can run the following command:

```bash
flutter test
```
