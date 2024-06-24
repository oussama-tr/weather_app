import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/city/domain/usecases/add_city.dart';
import 'package:weather_app/features/city/domain/usecases/delete_city.dart';
import 'package:weather_app/features/city/domain/usecases/get_cities.dart';
import 'package:weather_app/features/city/domain/usecases/get_selected_city.dart';
import 'package:weather_app/features/city/domain/usecases/set_selected_city.dart';
import 'package:weather_app/features/city/presentation/bloc/city_event.dart';
import 'package:weather_app/features/city/presentation/bloc/city_state.dart';

/// BLoC (Business Logic Component) responsible for managing city-related state
///  and business logic.
///
/// This BLoC handles various city-related events such as loading cities,
/// adding a city, deleting a city, and selecting a city. It coordinates with
/// use cases to perform these operations and manages the state of the UI
/// accordingly.
class CityBloc extends Bloc<CityEvent, CityState> {
  final GetCities getCities;
  final AddCity addCity;
  final DeleteCity deleteCity;
  final GetSelectedCity getSelectedCity;
  final SetSelectedCity setSelectedCity;

  /// Constructs a [CityBloc] instance with the necessary use cases.
  ///
  /// [getCities], [addCity], [deleteCity], [getSelectedCity], and
  /// [setSelectedCity] are dependencies representing use cases for
  /// respective city operations.
  CityBloc({
    required this.getCities,
    required this.addCity,
    required this.deleteCity,
    required this.getSelectedCity,
    required this.setSelectedCity,
  }) : super(CityInitial()) {
    on<LoadCities>(_onLoadCities);
    on<AddCityEvent>(_onAddCity);
    on<DeleteCityEvent>(_onDeleteCity);
    on<SelectCityEvent>(_onSelectCity);
  }

  /// Handler for the [LoadCities] event.
  ///
  /// Triggers the loading of cities and emits appropriate state changes based
  /// on the result.
  void _onLoadCities(LoadCities event, Emitter<CityState> emit) async {
    emit(CitiesLoading());
    try {
      final citiesEither = await getCities(NoParams());
      final selectedCityEither = await getSelectedCity(NoParams());
      citiesEither.fold(
        (failure) => emit(CityOperationFailure(failure.toString())),
        (cities) {
          final selectedCity = selectedCityEither.getOrElse(() => null);
          emit(CitiesLoaded(cities, selectedCity));
        },
      );
    } catch (e) {
      emit(CityOperationFailure(e.toString()));
    }
  }

  /// Handler for the [AddCityEvent] event.
  ///
  /// Adds a new city and updates the UI state accordingly.
  void _onAddCity(AddCityEvent event, Emitter<CityState> emit) async {
    try {
      await addCity(AddCityParams(city: event.city));
      final citiesEither = await getCities(NoParams());
      final selectedCityEither = await getSelectedCity(NoParams());
      citiesEither.fold(
        (failure) => emit(CityOperationFailure(failure.toString())),
        (cities) {
          final selectedCity = selectedCityEither.getOrElse(() => null);
          emit(CitiesLoaded(cities, selectedCity));
        },
      );
    } catch (e) {
      emit(CityOperationFailure(e.toString()));
    }
  }

  /// Handler for the [DeleteCityEvent] event.
  ///
  /// Deletes a city and updates the UI state accordingly.
  void _onDeleteCity(DeleteCityEvent event, Emitter<CityState> emit) async {
    try {
      await deleteCity(DeleteCityParams(city: event.city));
      final citiesEither = await getCities(NoParams());
      final selectedCityEither = await getSelectedCity(NoParams());
      citiesEither.fold(
        (failure) => emit(CityOperationFailure(failure.toString())),
        (cities) {
          final selectedCity = selectedCityEither.getOrElse(() => null);
          emit(CitiesLoaded(cities, selectedCity));
        },
      );
    } catch (e) {
      emit(CityOperationFailure(e.toString()));
    }
  }

  /// Handler for the [SelectCityEvent] event.
  ///
  /// Selects a city and updates the UI state accordingly.
  void _onSelectCity(SelectCityEvent event, Emitter<CityState> emit) async {
    try {
      await setSelectedCity(SetSelectedCityParams(city: event.city));
      final citiesEither = await getCities(NoParams());
      final selectedCityEither = await getSelectedCity(NoParams());
      citiesEither.fold(
        (failure) => emit(CityOperationFailure(failure.toString())),
        (cities) {
          final selectedCity = selectedCityEither.getOrElse(() => null);
          emit(CitiesLoaded(cities, selectedCity));
        },
      );
    } catch (e) {
      emit(CityOperationFailure(e.toString()));
    }
  }
}
