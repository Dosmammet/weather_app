import 'dart:convert';

import 'package:weather_app/common/config.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/feature/data/models/city_model.dart';
import 'package:weather_app/feature/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
abstract class WeatherRemoteDataSource{
  Future<List<WeatherModel>> getDailyWeather(String lat, String long);
  Future<List<WeatherModel>> getHourlyWeather(String lat, String long);
  Future<CityModel> getCity(String lat, String long);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource{
  WeatherRemoteDataSourceImpl({
    required this.client
  });
  final http.Client client;
  @override
  Future<List<WeatherModel>> getDailyWeather(String lat, String long) =>_getWeathersFromUrl('http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&units=metric&appid=1a19aa6a7226df0fe9fa99a91de215ca');

  @override
  Future<List<WeatherModel>> getHourlyWeather(String lat, String long) => _getWeathersFromUrl(Config().url+'lat=$lat&lon=$long&appid=${Config().apiKey}');
  @override
  Future<CityModel> getCity(String lat, String long) async{
     print('fetching City');
     final response = await client.get(Uri.parse('http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&units=metric&appid=1a19aa6a7226df0fe9fa99a91de215ca'), 
    headers: {'Content-Type':'application/json'});
    if (response.statusCode ==200){
      final city = jsonDecode(response.body);
      return CityModel.fromJson(city['city'] as Map<String, dynamic>);
    }else{
      print(response.statusCode);
      print(response.body);
      throw ServerException();
    }
  }
  Future<List<WeatherModel>> _getWeathersFromUrl(String url)async{
    print('fetching');
     final response = await client.get(Uri.parse(url), 
    headers: {'Content-Type':'application/json'});
    if (response.statusCode ==200){
      final weathers = jsonDecode(response.body);
      return (weathers['list'] as List).map((weather) => WeatherModel.fromJson(weather)).toList();
    }else{
      print(response.statusCode);
      print(response.body);
      print(url);
      throw ServerException();
    }
   
  }
  

}