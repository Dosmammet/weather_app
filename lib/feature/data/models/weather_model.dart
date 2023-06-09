import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity{
  WeatherModel({required super.dt, required super.title,required super.desc, required super.dtText,required super.feelsLike,required super.humidity,required super.temp});
  
  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(dt: json['dt'].toString(),title: json['weather'][0]['main'].toString(),desc: json['weather'][0]['description'].toString(), dtText: json['dt_txt'],feelsLike: json['main']['feels_like'].toString(),humidity: json['main']['humidity'].toString(),temp: json['main']['temp'].toString());
  }
  Map<String, dynamic> toJson(){
    return {
      'dt':dt,
      'dt_txt':dtText,
      'main':{'feels_like':feelsLike, 'temp':temp, 'humidity':humidity},
      'weather':[{'main':title, 'description':desc}]
    };
  }
}