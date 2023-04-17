import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_cubit.dart';

import '../../../main.dart';
import '../bloc/weather_hourly_cubit/weather_hourly_cubit.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  // void _changeLanguage(Language language) async {
  //   Locale _locale = await setLocale(language.languageCode);
  //   MyApp.setLocale(context, _locale);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            'languages'.tr(),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                context.locale = Locale('en', "RU");
                langweb = 'ru';
                BlocProvider.of<CityCubit>(context).loadCity();
                BlocProvider.of<WeatherDailyCubit>(context).loadWeather();
                //BlocProvider.of<WeatherHourlyCubit>(context).loadWeather();
              },
              leading: Icon(
                Icons.language,
              ),
              title: Text(
                'Russian'.tr(),
                style: TextStyle(),
              ),
            ),
            ListTile(
              onTap: () {
                langweb = 'en';
                context.locale = Locale('en', "RU");
                BlocProvider.of<CityCubit>(context).loadCity();
                BlocProvider.of<WeatherDailyCubit>(context).loadWeather();
                //BlocProvider.of<WeatherHourlyCubit>(context).loadWeather();
              },
              leading: Icon(
                Icons.language,
              ),
              title: Text(
                'English'.tr(),
                style: TextStyle(),
              ),
            ),
          ],
        ));
  }
}
