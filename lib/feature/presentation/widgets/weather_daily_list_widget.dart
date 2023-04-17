import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_state.dart';
import 'package:weather_app/feature/presentation/widgets/weather_card_widget.dart';

class WeatherDailyList extends StatelessWidget {
  final bool hourly;

  const WeatherDailyList({super.key, required this.hourly});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherDailyCubit, WeatherDailyState>(
        builder: (context, state) {
      List<WeatherEntity> weather = [];
      bool isLoading = false;

      if (state is WeatherDailyLoading) {
        return _loadingIndicator();
      } else if (state is WeatherDailyLoading) {
        weather = state.oldWeathersList;
        isLoading = true;
      } else if (state is WeatherDailyLoaded) {
        weather = state.weathersList;
      } else if (state is WeatherDailyError) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      //return  Text(weather.toString());

      return hourly
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // controller: scrollController,
              itemBuilder: (context, index) {
                if (index < weather.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WeatherCard(
                      weather: weather[index],
                      hourly: hourly,
                    ),
                  );
                } else {
                  return _loadingIndicator();
                }
              },
              itemCount: weather.length + (isLoading ? 1 : 0),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // controller: scrollController,
              itemBuilder: (context, index) {
                if (index < weather.length) {
                  if (index > 0 && hourly == false) {
                    if (weather[index].dtText.toString().substring(0, 10) !=
                        weather[index - 1].dtText.toString().substring(0, 10)) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WeatherCard(
                          weather: weather[index],
                          hourly: hourly,
                        ),
                      );
                    }
                  }
                  return SizedBox();
                } else {
                  return _loadingIndicator();
                }
              },
              itemCount: weather.length + (isLoading ? 1 : 0),
            );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
