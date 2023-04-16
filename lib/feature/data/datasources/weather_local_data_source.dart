import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/feature/data/models/city_model.dart';
import 'package:weather_app/feature/data/models/weather_model.dart';

abstract class WeatherLocalDataSource{
  Future<List<WeatherModel>>getLastWeathersFromCache();
  Future<CityModel>getCityFromCache();
  Future <void> weathersToCache(List<WeatherModel> weathers);

    Future <void> cityToCache(CityModel weathers);
}
const CACHED_WEATHERS_LIST = 'CACHED_WEATHERS_LIST';
const CACHED_CITY = 'CACHED_CITY';
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource{
  WeatherLocalDataSourceImpl({
    required this.sharedPreferences
  });
  final SharedPreferences sharedPreferences;
  @override
  Future<List<WeatherModel>> getLastWeathersFromCache() {
  final jsonWeathersList = sharedPreferences.getStringList(CACHED_WEATHERS_LIST);
  if (jsonWeathersList !=null){
  return Future.value(jsonWeathersList.map((weather) => WeatherModel.fromJson(jsonDecode(weather))).toList());

  }else{
    throw CacheException();
  }
  
  }

  Future<CityModel> getCityFromCache() {
  final jsonCity = sharedPreferences.getString(CACHED_CITY);
  if (jsonCity !=null){
  return Future.value( CityModel.fromJson(jsonDecode(jsonCity)));

  }else{
    throw CacheException();
  }
  
  }

  @override
  Future<void> weathersToCache(List<WeatherModel> weathers) {
   final List<String> jsonWeathersList = weathers.map((weather) => jsonEncode(weather.toJson())).toList();
   sharedPreferences.setStringList(CACHED_WEATHERS_LIST, jsonWeathersList);
 
   print('Weather to cache: ${jsonWeathersList.length}');
   return Future.value(jsonWeathersList);
  }

  Future<void> cityToCache(CityModel city) {

   sharedPreferences.setString(CACHED_CITY, jsonEncode(city.toJson()));
   print('City to cache:');
   return Future.value(jsonEncode(city.toJson()));
  }

}