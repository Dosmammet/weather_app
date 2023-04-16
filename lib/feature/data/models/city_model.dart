import 'package:weather_app/feature/domain/entities/city_entity.dart';

class CityModel extends CityEntity{
  CityModel({required super.id, required super.name, required super.lat, required super.long});
  factory CityModel.fromJson(Map<String, dynamic> json){
    return CityModel(id: json['id'],name: json['name'],lat: json['lat'], long:json['long']);
  }
  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'lat':lat,
      'long':long,
    };
  }
}