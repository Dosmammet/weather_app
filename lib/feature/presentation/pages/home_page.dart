import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_cubit.dart';
import 'package:weather_app/feature/presentation/pages/languages.dart';
import 'package:weather_app/feature/presentation/widgets/city_widget.dart';

import 'package:weather_app/feature/presentation/widgets/weather_daily_list_widget.dart';

import '../bloc/city_cubit/city_state.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather'.tr()),
          centerTitle: true,
         bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).colorScheme.onPrimary,
            tabs: [
              // Tab(
              //   text: 'all'.tr,
              // ),
              Tab(
                text: 'Daily'.tr(),
              ),
              // Tab(
              //   text: 'Testing'.tr,
              // ),
              Tab(
                text: 'Hourly'.tr(),
              ),
            ],
          ),
          actions: [IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
          }, icon: Icon(Icons.language))],
        ),
        body: TabBarView(
          children: [
          dailyTab(context),
          hourlyTab(context)            
          ],
        ),
      ),
    );
  }
}
Widget dailyTab(BuildContext context){
 return SingleChildScrollView(
              child: Column(
                children: [
                 CityWidget(),
                  WeatherDailyList(hourly: false,),
                ],
              ),
            );
}

Widget hourlyTab(BuildContext context){
 return SingleChildScrollView(
              child: Column(
                children: [
                 CityWidget(),
                  WeatherDailyList(hourly: true,),
                ],
              ),
            );
}
