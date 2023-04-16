import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/feature/data/models/city_model.dart';
import 'package:weather_app/feature/domain/repository/weather_repository.dart';

import '../../../core/error/failure.dart';
import '../entities/weather_entity.dart';

class GetCity extends Usecase<CityModel, GetCityParams>{
  GetCity({
    required this.weatherRepository
  });
  final WeatherRepository weatherRepository;
  
   Future<Either<Failure,CityModel>> call(GetCityParams params){
    print(' gettin city');
    return  weatherRepository.getCity(params.lat, params.long);
   }
}

class GetCityParams extends Equatable {
  final String lat;
  final String long;
 const GetCityParams({required this.lat, required this.long});
  
  @override
  // TODO: implement props
  List<Object?> get props => [lat, long];
}