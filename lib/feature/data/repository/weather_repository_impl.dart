
import 'package:dartz/dartz.dart';


import 'package:weather_app/feature/data/datasources/weather_local_data_source.dart';
import 'package:weather_app/feature/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/feature/data/models/city_model.dart';
import 'package:weather_app/feature/data/models/weather_model.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/domain/repository/weather_repository.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../core/platform/network_info.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<WeatherEntity>>> getDailyWeather(String lat, String long) async {
    print('getting1');
    return await _getWeathersFromUrl(() {
      return remoteDataSource.getDailyWeather(lat, long);
    });
  }

  @override
  Future<Either<Failure, List<WeatherEntity>>> getHourlyWeather(String lat, String long) async {
    print('getting2');
    return await _getWeathersFromUrl(() {
      return remoteDataSource.getHourlyWeather(lat, long);
    });
  }

  Future<Either<Failure, List<WeatherModel>>> _getWeathersFromUrl(
      Future<List<WeatherModel>> Function() getWeathers,) async {
    if (await networkInfo.isConnected) {
      try {
        print('network connected');
        final remoteWeather = await getWeathers();
      
        localDataSource.weathersToCache(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        print('network not connected');
        final localWeather = await localDataSource.getLastWeathersFromCache();
        return Right(localWeather);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CityModel>> getCity(String lat, String long) async{
    if (await networkInfo.isConnected) {
      try {
        print('network connected');
        final remoteCity = await remoteDataSource.getCity(lat, long);
  
        localDataSource.cityToCache(remoteCity);
        return Right(remoteCity);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        print('network not connected');
        final localCity = await localDataSource.getCityFromCache();
        return Right(localCity);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
