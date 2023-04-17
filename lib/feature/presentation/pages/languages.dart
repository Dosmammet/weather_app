import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

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
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                context.locale = Locale('en', "RU");
      
              },
              leading: Icon(
                Icons.language,
                color: context.locale.toString() == 'en_RU'
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorDark,
              ),
              title: Text(
                'Russian'.tr(),
                style: TextStyle(
                    color: context.locale.toString() == 'en_RU'
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark),
              ),
            ),
            ListTile(
              onTap: () {
                context.locale = Locale('en', "US");
          
              },
              leading: Icon(Icons.language,
                  color: context.locale.toString() == 'en_US'
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark),
              title: Text(
                'English'.tr(),
                style: TextStyle(
                    color: context.locale.toString() == 'en_US'
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        ));
  }
}
