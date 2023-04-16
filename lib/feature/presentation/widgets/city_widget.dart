import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/data/models/city_model.dart';
import 'package:weather_app/feature/domain/entities/weather_entity.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_state.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_state.dart';
import 'package:weather_app/feature/presentation/widgets/weather_card_widget.dart';


class CityWidget extends StatelessWidget {
  final scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {


    return BlocBuilder<CityCubit, CityState>(builder: (context, state) {


      if (state is CityLoading) {
        return _loadingIndicator();
      }  else if (state is CityLoaded) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Weather in', style: TextStyle(fontSize: 18),),
              Text(state.city.name.toString(), style: TextStyle(fontSize: 36),),
            ],
          ),
        );
      } else if (state is CityError) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      }
      return Text('123');
      
      // ListView.separated(
      //   controller: scrollController,
      //   itemBuilder: (context, index) {
      //     if (index < weather.length) {
      //       return WeatherCard(weather: weather[index]);
      //     } else {
      //       Timer(Duration(milliseconds: 30), () {
      //         scrollController
      //             .jumpTo(scrollController.position.maxScrollExtent);
      //       });
      //       return _loadingIndicator();
      //     }
      //   },
      //   separatorBuilder: (context, index) {
      //     return Divider(
      //       color: Colors.grey[400],
      //     );
      //   },
      //   itemCount: weather.length + (isLoading ? 1 : 0),
      // );
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
