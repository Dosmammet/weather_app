import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';

import '../../../common/app_colors.dart';


class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datetime = DateTime.parse(weather.dtText).toLocal();
    final f = new   DateFormat.yMd().add_jm() ;

    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
               
                  Text(
                    f.format(datetime),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                 Text(
                    'Temperature: ${weather.temp} C',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Humidity: ${weather.humidity}',
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                   Text(
                    'Feels like: ${weather.feelsLike}',
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                 
                ],
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
