import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottery_kr/Home.dart';
import 'package:lottery_kr/firebase_options.dart';
import 'package:lottery_kr/service/AnalyticService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  MobileAds.instance.initialize();

  String language = 'en';
  if (window.locale.languageCode == 'en' || window.locale.languageCode == 'es' || window.locale.languageCode == 'it' || window.locale.languageCode == 'ko' || window.locale.languageCode == 'ja' || window.locale.languageCode == 'de' || window.locale.languageCode == 'zh' || window.locale.languageCode == 'hi') {
    language = window.locale.languageCode;
  }
  else {
    language = 'en';
  }

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('es'), Locale('it'), Locale('ko'), Locale('ja'), Locale('de'), Locale('zh'), Locale('hi')],
    path: 'assets/translations', // Path to your language files
    fallbackLocale: Locale(language),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,  
      navigatorObservers: [
        AnalyticService.instance.getAnalyticsObserver()
      ],    
      home: Home()
    );
  }
}