import 'package:easy_localization/easy_localization.dart';
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
import 'feature/presentation/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await di.init();
  await setLatLong();
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('en', 'RU'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'RU'),
      saveLocale: true,
      child: MyApp()));
}

getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
// Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null;
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return null;
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(position);
  if (position != null) {
    LAT = position.latitude.toStringAsFixed(2);
    LON = position.longitude.toStringAsFixed(2);
  }
}

setLatLong() async {
  Position pos = await getLocation();
  if (pos != null) {
    LAT = pos.latitude.toStringAsFixed(2);
    LON = pos.longitude.toStringAsFixed(2);
  }
}

String LAT = '44.34';
String LON = '10.99';
String langweb = 'en_US';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    langweb = context.locale == Locale('en', "RU") ? 'ru' : 'en';
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherDailyCubit>(
            create: (context) => sl<WeatherDailyCubit>()..loadWeather()),
        // BlocProvider<WeatherHourlyCubit>(
        //     create: (context) => sl<WeatherHourlyCubit>()),
        BlocProvider<CityCubit>(
            create: (context) => sl<CityCubit>()..loadCity()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        home: SplashScreen(),
      ),
    );
  }
}
