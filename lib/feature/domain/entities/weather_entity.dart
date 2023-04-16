
import 'package:equatable/equatable.dart';
class WeatherEntity extends Equatable{
  WeatherEntity({
    required this.dt,

    required this.dtText,
    required this.temp,
    required this.feelsLike,
    required this.humidity
  });
  final String dt;

  final String dtText;
  final String temp;
  final String feelsLike;
  final String humidity;

  
  @override
  // TODO: implement props
  List<Object?> get props => [dt, dtText, temp, feelsLike, humidity];
}