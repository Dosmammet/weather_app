import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/feature/domain/repository/weather_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/weather_entity.dart';

class GetDailyWeather extends Usecase<List<WeatherEntity>, GetDailyWeatherParams>{
  GetDailyWeather({
    required this.weatherRepository
  });
  final WeatherRepository weatherRepository;
  
   Future<Either<Failure,List<WeatherEntity>>> call(GetDailyWeatherParams params){
    print(' gettin daily');
    return  weatherRepository.getDailyWeather(params.lat, params.long);
   }
}

class GetDailyWeatherParams extends Equatable {
  final String lat;
  final String long;
 const GetDailyWeatherParams({required this.lat, required this.long});
  
  @override
  // TODO: implement props
  List<Object?> get props => [lat, long];
}