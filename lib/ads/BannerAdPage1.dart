import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdPage1 extends StatefulWidget {
  const BannerAdPage1({super.key});

  @override
  State<BannerAdPage1> createState() => _BannerAdPage1State();
}

class _BannerAdPage1State extends State<BannerAdPage1> {
  final String androidUnitId = "ca-app-pub-3940256099942544/6300978111";
  final String iosUnitId = "ca-app-pub-3940256099942544/2435281174";
  
  // final String realIosUnitId = "ca-app-pub-6838337741832324/7514328519";
  // final String realAndroidUnitId = "ca-app-pub-6838337741832324/4864114449";

  late BannerAd? banner;
  bool isBannerLoaded = false;

  @override
  void initState() {
    super.initState();

    initializeBannerAd();
  }

  initializeBannerAd() async {
    banner = BannerAd(
            size: AdSize.banner, 
            adUnitId: Platform.isIOS? iosUnitId : androidUnitId, 
            // adUnitId: Platform.isIOS? realIosUnitId : realAndroidUnitId, 
            listener: BannerAdListener(
              onAdLoaded: (ad) {
                if (this.mounted) {
                  setState(() {
                    isBannerLoaded = true;
                  });
                }
              },
              onAdFailedToLoad: (ad, error) {
                ad.dispose();
                isBannerLoaded = false;
              }
            ), 
            request: AdRequest())..load();

  }

  @override
  Widget build(BuildContext context) {
    return !isBannerLoaded ? 
    SizedBox(height: 0) :
    Container(
      height: 80,
      child: AdWidget(
            ad: this.banner!)
    );
  }
}