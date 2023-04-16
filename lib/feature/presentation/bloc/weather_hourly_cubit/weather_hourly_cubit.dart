
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/domain/usecases/get_hourly_weather.dart';
import 'package:weather_app/feature/presentation/bloc/weather_hourly_cubit/weather_hourly_state.dart';

import '../../../../core/error/failure.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class WeatherHourlyCubit extends Cubit<WeatherHourlyState> {
  final GetHourlyWeather getHourlyWeather;

  WeatherHourlyCubit({required this.getHourlyWeather}) : super(WeatherHourlyEmpty());


  void loadWeather() async {
    if (state is WeatherHourlyLoading) return;

    final currentState = state;

    var oldWeather = <WeatherEntity>[];
    if (currentState is WeatherHourlyLoaded) {
      oldWeather = currentState.weathersList;
    }

    emit(WeatherHourlyLoading(oldWeather));

    final failureOrWeather = await getHourlyWeather(GetHourlyWeatherParams(lat: '44.34', long: '10.99',days: '3'));

    failureOrWeather.fold((error) => emit(WeatherHourlyError(message: _mapFailureToMessage(error))), (character) {
      final persons = (state as WeatherHourlyLoading).oldWeathersList;
      persons.addAll(character);
      print('List length: ${persons.length.toString()}');
      emit(WeatherHourlyLoaded(character));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

}