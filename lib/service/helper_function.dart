import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void createRewardedAds(BuildContext context) async {
    await RewardedAd.load(
      // adUnitId: Platform.isAndroid ? 'ca-app-pub-6838337741832324/3753923774'
      //     : 'ca-app-pub-6838337741832324/7611910751',
      adUnitId: Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917'
        : 'ca-app-pub-7319269804560504/2207757133',
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
        },
      ),
    );
  }

  void expandNumberLimit() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int currentLimit = prefs.getInt('numberLimit') ?? 20; // default to 0 if not set
      if (currentLimit < 70) {
        currentLimit += 10; // increment by 10
        await prefs.setInt('numberLimit', currentLimit); // save the updated value
      }
    } catch (e) {
      print(e);
    }
  }


  // void showToastMsg(String msg, BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(msg),
  //   ));
  // }
}