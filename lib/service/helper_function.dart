import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottery_kr/data/LotteryDetails.dart';
import 'package:lottery_kr/page/CompareLotto.dart';
import 'package:lottery_kr/page/Result.dart';
import 'package:lottery_kr/page/discussion/DiscussionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class HelperFunctions {

  static final HelperFunctions _instance = HelperFunctions._internal();

  factory HelperFunctions() {
    return _instance;
  }

  HelperFunctions._internal();

  String usersLoggedInKey = "LOGGEDINKEY";
  String userNameKey = "USERNAMEKEY";
  String userEmailKey = "USEREMAILKEY";
  String userUidKey = "USERUIDKEY";
  String verifiedKey = "VERIFIED";

  Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(usersLoggedInKey, isUserLoggedIn);
  }

  Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  Future<bool> saveUserUIdSF(String uid) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userUidKey, uid);
  }

  Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    dynamic value = sf.get(userNameKey);
    if (value == null) {
      return null;
    }
    else if (value is String) {
      return value;
    } else {
      throw Exception('Invalid value type for key $userNameKey');
    }
  }

  Future<bool> saveVerifiedSF(bool isVerified) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(verifiedKey, isVerified);
  }

  Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    dynamic value = sf.get(userEmailKey);
    if (value == null) {
      return null;
    } 
    else if (value is String) {
      return value;
    } else {
      throw Exception('Invalid value type for key $userEmailKey');
    }
  }

  Future<String?> getUserUIdFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    dynamic value = sf.get(userUidKey);
    if (value == null) {
      return null;
    } 
    else if (value is String) {
      return value;
    } else {
      throw Exception('Invalid value type for key $userEmailKey');
    }
  }

  Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    dynamic value = sf.get(usersLoggedInKey);
    if (value == null) {
      return null;
    } else if (value is bool) {
      return value;
    } else if (value is String) {
      return value.toLowerCase() == 'true';
    } else {
      throw Exception('Invalid value type for key $usersLoggedInKey');
    }
  }

  Future<bool?> getUserVerifiedStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    dynamic value = sf.get(verifiedKey);
    if (value == null) {
      return null;
    } else if (value is bool) {
      return value;
    } else if (value is String) {
      return value.toLowerCase() == 'true';
    } else {
      throw Exception('Invalid value type for key $verifiedKey');
    }
  }

  void goToResult(BuildContext context) async {
    bool result = await InternetConnection().hasInternetAccess;
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Result()),
      );
    }
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("wifiNeeded".tr()),
          content: Text("requireWifi".tr()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  void goToCompare(BuildContext context) {
    LotteryDetails lotteryDetails = new LotteryDetails();
    List<Map<String, dynamic>> details = lotteryDetails.getLotteryDetails();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompareLotto(lotteryDetails: details)),
    );
  }

  void goToDiscussion(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiscussionPage()),
    );
  }

  Future createRewardedAds(BuildContext context) async {
    await RewardedAd.load(
      // adUnitId: Platform.isAndroid ? 'ca-app-pub-6838337741832324/3753923774'
      //     : 'ca-app-pub-6838337741832324/7611910751',
      adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917'
        : 'ca-app-pub-3940256099942544/1712485313', // test id
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              ad.dispose();
            },
          );
          ad.show(onUserEarnedReward: (ad, reward) {
            expandNumberLimit();
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print(error.message);
        },
      ),
    );
  }

  void expandNumberLimit() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int currentLimit = prefs.getInt('capacity') ?? 10; // default to 0 if not set
      if (currentLimit < 30) {
        currentLimit += 10; // increment by 10
        await prefs.setInt('capacity', currentLimit); // save the updated value
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, List<int>>?> askExpandCapacityDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
        barrierDismissible: false, // Prevents closing the dialog when tapping outside
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('generationLimit'.tr()),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('askExpand'.tr())
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('no'.tr()),
              ),
              TextButton(
                onPressed: () async {
                  await createRewardedAds(context);
                  Navigator.of(context).pop();
                },
                child: Text('yes'.tr()),
              ),
            ],
          );
        },
      );
    return null;
  }


  // void showToastMsg(String msg, BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(msg),
  //   ));
  // }
}