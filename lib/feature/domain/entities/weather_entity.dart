
import 'package:equatable/equatable.dart';
class WeatherEntity extends Equatable{
  WeatherEntity({
    required this.dt,

    required this.dtText,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
     required this.title,
      required this.desc,
  });
  final String dt;

  final String dtText;
  final String temp;
  final String feelsLike;
  final String humidity;
    final String title;
      final String desc;

  
  @override
  // TODO: implement props
  List<Object?> get props => [dt, dtText, temp, feelsLike, humidity,title, desc];
}