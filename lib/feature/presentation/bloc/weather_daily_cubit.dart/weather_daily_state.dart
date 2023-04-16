import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/weather_entity.dart';

abstract class WeatherDailyState extends Equatable {
  const WeatherDailyState();

  @override
  List<Object> get props => [];
}

class WeatherDailyEmpty extends WeatherDailyState {
  @override
  List<Object> get props => [];
}

class WeatherDailyLoading extends WeatherDailyState {
  final List<WeatherEntity> oldWeathersList;
  //final bool isFirstFetch;

  WeatherDailyLoading(this.oldWeathersList);

  @override
  List<Object> get props => [oldWeathersList];
  
}

class WeatherDailyLoaded extends WeatherDailyState {
  final List<WeatherEntity> weathersList;

  WeatherDailyLoaded(this.weathersList);

  @override
  List<Object> get props => [weathersList];
}

class WeatherDailyError extends WeatherDailyState {
  final String message;

  WeatherDailyError({required this.message});
  
  @override
  List<Object> get props => [message];
}