import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_hourly_cubit/weather_hourly_cubit.dart';
import 'package:weather_app/locator_service.dart' as di;
import 'package:weather_app/locator_service.dart';

import 'common/app_colors.dart';
import 'feature/presentation/pages/home_page.dart';
void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  getLocation();
  runApp( MyApp());
}

getLocation()async{
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherDailyCubit>(
            create: (context) => sl<WeatherDailyCubit>()..loadWeather()),
        BlocProvider<WeatherHourlyCubit>(
            create: (context) => sl<WeatherHourlyCubit>()),
              BlocProvider<CityCubit>(
            create: (context) => sl<CityCubit>()..loadCity()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: HomePage(),
      ),
    );
  }
}

