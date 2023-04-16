import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/weather_entity.dart';

abstract class WeatherHourlyState extends Equatable {
  const WeatherHourlyState();

  @override
  List<Object> get props => [];
}

class WeatherHourlyEmpty extends WeatherHourlyState {
  @override
  List<Object> get props => [];
}

class WeatherHourlyLoading extends WeatherHourlyState {
  final List<WeatherEntity> oldWeathersList;
  //final bool isFirstFetch;

  WeatherHourlyLoading(this.oldWeathersList);

  @override
  List<Object> get props => [oldWeathersList];
  
}

class WeatherHourlyLoaded extends WeatherHourlyState {
  final List<WeatherEntity> weathersList;

  WeatherHourlyLoaded(this.weathersList);

  @override
  List<Object> get props => [weathersList];
}

class WeatherHourlyError extends WeatherHourlyState {
  final String message;

  WeatherHourlyError({required this.message});
  
  @override
  List<Object> get props => [message];
}