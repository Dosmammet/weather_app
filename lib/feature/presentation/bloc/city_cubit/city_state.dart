import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/feature/data/models/city_model.dart';

import '../../../domain/entities/weather_entity.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityEmpty extends CityState {
  @override
  List<Object> get props => [];
}

class CityLoading extends CityState {



  CityLoading();

  @override
  List<Object> get props => [];
  
}

class CityLoaded extends CityState {
  final CityModel city;

  CityLoaded(this.city);

  @override
  List<Object> get props => [city];
}

class CityError extends CityState {
  final String message;

  CityError({required this.message});
  
  @override
  List<Object> get props => [message];
}