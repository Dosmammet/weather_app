import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';

import '../../../common/app_colors.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;
  final bool hourly;
  const WeatherCard({Key? key, required this.weather, required this.hourly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datetime = DateTime.parse(weather.dtText).toLocal();
    final f = hourly ? DateFormat.yMd().add_jm() : DateFormat.yMd();

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ExpandablePanel(
            header: Text(
              f.format(datetime),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            collapsed: Text(
              weather.desc,
              style: TextStyle(fontSize: 18),
            ),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather.desc,
                  textAlign: TextAlign.left,
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
                  textAlign: TextAlign.left,
                  'Temperature'.tr() + ': ${weather.temp} C',
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
                  'Humidity'.tr() + ': ${weather.humidity}',
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Feels like'.tr() + ': ${weather.feelsLike}',
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
