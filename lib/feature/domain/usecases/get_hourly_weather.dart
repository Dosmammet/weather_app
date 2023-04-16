import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/feature/domain/repository/weather_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/weather_entity.dart';

class GetHourlyWeather extends Usecase<List<WeatherEntity>, GetHourlyWeatherParams>{
  GetHourlyWeather({
    required this.weatherRepository
  });
  final WeatherRepository weatherRepository;
  
   Future<Either<Failure,List<WeatherEntity>>> call(GetHourlyWeatherParams params)async{
    return await weatherRepository.getHourlyWeather(params.lat, params.long);
   }
}

class GetHourlyWeatherParams extends Equatable{
  GetHourlyWeatherParams({
    required this.lat,
    required this.long,
    required this.days
  });
  String lat;
  String long;
  String days;
  
  @override
  // TODO: implement props
  List<Object?> get props => [lat, long, days];

}