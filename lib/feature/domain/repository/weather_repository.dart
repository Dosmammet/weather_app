import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/feature/data/models/city_model.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';

abstract class WeatherRepository{
  Future<Either<Failure,List<WeatherEntity>>> getDailyWeather(String lat, String long);
   Future<Either<Failure,List<WeatherEntity>>> getHourlyWeather(String lat, String long);

   Future<Either<Failure,CityModel>> getCity(String lat, String long);
}