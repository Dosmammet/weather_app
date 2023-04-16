import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_state.dart';
import 'package:weather_app/feature/presentation/widgets/weather_card_widget.dart';


class WeatherList extends StatelessWidget {
  final scrollController = ScrollController();
  int page = -1;
  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          //BlocProvider.of<WeatherDailyCubit>(context).loadWeather();
          context.read<WeatherDailyCubit>().loadWeather();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<WeatherDailyCubit, WeatherDailyState>(builder: (context, state) {
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
      
      return ListView.separated(
       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       // controller: scrollController,
        itemBuilder: (context, index) {
          if (index < weather.length) {
            return WeatherCard(weather: weather[index]);
          } else {
            Timer(Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
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
