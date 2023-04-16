import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_cubit.dart';
import 'package:weather_app/feature/presentation/widgets/city_widget.dart';

import 'package:weather_app/feature/presentation/widgets/weather_daily_list_widget.dart';

import '../bloc/city_cubit/city_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        centerTitle: true,
      
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           CityWidget(),
            WeatherList(),
          ],
        ),
      ),
    );
  }
}
