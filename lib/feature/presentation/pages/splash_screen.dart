import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/feature/presentation/bloc/city_cubit/city_cubit.dart';
import 'package:weather_app/feature/presentation/bloc/weather_daily_cubit.dart/weather_daily_cubit.dart';
import 'package:weather_app/feature/presentation/pages/home_page.dart';

import '../../../common/app_colors.dart';
import '../../../main.dart';
import '../bloc/weather_hourly_cubit/weather_hourly_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    go();
  }

  Future go() async {
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('BAZAR'),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          );
        } else {
          return Stack(
            children: [
              Container(
                color: AppColors.mainBackground,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: Container(
                  //color: Colors.red,
                  height: 250,
                  child: Image(
                    image: AssetImage('assets/images/weather_logo.png'),
                    // color: Theme.of(context).primaryColorDark,
                    // height: 200,
                    // width: 200,
                    fit: BoxFit.cover,
                    // child: Text('BAZARRR'),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.75,
                left: MediaQuery.of(context).size.width * 0.45,
                child: SpinKitFadingCircle(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.white : Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
