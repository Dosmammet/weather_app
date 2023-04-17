
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/feature/domain/entities/weather_entity.dart';

import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_state.dart';
import 'package:weather_app/main.dart';


import '../../../../core/error/failure.dart';
import '../../../domain/usecases/get_daily_weather.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class WeatherDailyCubit extends Cubit<WeatherDailyState> {
  final GetDailyWeather getDailyWeather;

  WeatherDailyCubit({required this.getDailyWeather}) : super(WeatherDailyEmpty());


  void loadWeather() async {
    print('loading');
    if (state is WeatherDailyLoading) return;

    final currentState = state;

    var oldWeather = <WeatherEntity>[];
    if (currentState is WeatherDailyLoaded) {
      oldWeather = currentState.weathersList;
    }
    
    emit(WeatherDailyLoading(oldWeather));

    final failureOrWeather = await getDailyWeather(GetDailyWeatherParams(lat: LAT, long: LON));

    failureOrWeather.fold((error) => emit(WeatherDailyError(message: _mapFailureToMessage(error))), (character) {
      final persons = (state as WeatherDailyLoading).oldWeathersList;
      persons.addAll(character);
      print('List length: ${persons.length.toString()}');
      emit(WeatherDailyLoaded(character));
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