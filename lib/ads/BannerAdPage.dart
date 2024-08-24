import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdPage extends StatefulWidget {
  const BannerAdPage({super.key});

  @override
  State<BannerAdPage> createState() => _BannerAddPageState();
}

class _BannerAddPageState extends State<BannerAdPage> {

  final String androidUnitId = "ca-app-pub-3940256099942544/6300978111";
  final String iosUnitId = "ca-app-pub-3940256099942544/2435281174";

  // final String realIosUnitId = "ca-app-pub-6838337741832324/8350097144";
  // final String realAndroidUnitId = "ca-app-pub-6838337741832324/4246937275";

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
                print(error.toString());
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