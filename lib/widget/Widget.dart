import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottery_kr/Home.dart';
import 'package:lottery_kr/data/LotteryDetails.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/page/CompareLotto.dart';
import 'package:lottery_kr/page/QrCodePage.dart';
import 'package:lottery_kr/page/Result.dart';
import 'package:lottery_kr/page/auth/LoginPage.dart';
import 'package:lottery_kr/service/DeletedAccounts.dart';
import 'package:lottery_kr/page/discussion/DiscussionPage.dart';
import 'package:lottery_kr/page/discussion/ShowBookmarkedPosts.dart';
import 'package:lottery_kr/page/discussion/ShowLikedPosts.dart';

class CommonWidget {

  CommonWidget._privateConstructor();

  static final CommonWidget instance = CommonWidget._privateConstructor();
  HelperFunctions helperFunctions = HelperFunctions();

  Widget drawerWidget(BuildContext context, String uid) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 56, 54, 54)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lotto World',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("homeBtn".tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("discussion".tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiscussionPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("likedPosts".tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowLikedPosts()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("bookmarkedPosts".tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowBookmarkedPosts()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("contact".tr()),
              onTap: () {
                Navigator.pop(context);
                showContactDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("deleteAccount".tr()),
              onTap: () {
                Navigator.pop(context);
                showAccountDeleteDialog(context, uid);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("language".tr()),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Select Language"),
                      content: Container(
                        height: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("english".tr()),
                                onTap: () {
                                  context.setLocale(Locale('en'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("german".tr()),
                                onTap: () {
                                  context.setLocale(Locale('de'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("spanish".tr()),
                                onTap: () {
                                  context.setLocale(Locale('es'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("italian".tr()),
                                onTap: () {
                                  context.setLocale(Locale('it'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("japanese".tr()),
                                onTap: () {
                                  context.setLocale(Locale('ja'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("korean".tr()),
                                onTap: () {
                                  context.setLocale(Locale('ko'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("chinese".tr()),
                                onTap: () {
                                  context.setLocale(Locale('zh'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("hindi".tr()),
                                onTap: () {
                                  context.setLocale(Locale('hi'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ),
                    );
                  }
                );
              }
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                   backgroundColor: Colors.grey[850],
                   padding: EdgeInsets.symmetric(horizontal: 100)
                ),
                child: Text(
                  "logout".tr(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  logout(context);
                },
              ),
            ),
          ],
        ),
      );
  }

  void logout(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    if (!kIsWeb) {
      await googleSignIn.signOut(); 
    }
    await FirebaseAuth.instance.signOut();
    await helperFunctions.saveUserLoggedInStatus(false);
    await helperFunctions.saveUserUIdSF("");
    await helperFunctions.saveVerifiedSF(false);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget homeDrawerWidget(BuildContext context, List<Color> background) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: [background[0], background[1]],
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lotto World',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("homeBtn".tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.compare_arrows),
              title: Text("compareLotto".tr()),
              onTap: () {
                LotteryDetails lotteryDetails = new LotteryDetails();
                List<Map<String, dynamic>> details = lotteryDetails.getLotteryDetails();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompareLotto(lotteryDetails: details)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("result".tr()),
              onTap: () async {
                Navigator.pop(context);
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
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("discussion".tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiscussionPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code_outlined),
              title: Text("qr".tr()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrCodePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.expand),
              title: Text("reward".tr()),
              onTap: () {
                Navigator.pop(context);
                showRewardDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("contact".tr()),
              onTap: () {
                Navigator.pop(context);
                showContactDialog(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("language".tr()),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Select Language"),
                      content: Container(
                        height: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("english".tr()),
                                onTap: () {
                                  context.setLocale(Locale('en'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("german".tr()),
                                onTap: () {
                                  context.setLocale(Locale('de'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("spanish".tr()),
                                onTap: () {
                                  context.setLocale(Locale('es'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("italian".tr()),
                                onTap: () {
                                  context.setLocale(Locale('it'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("japanese".tr()),
                                onTap: () {
                                  context.setLocale(Locale('ja'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("korean".tr()),
                                onTap: () {
                                  context.setLocale(Locale('ko'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("chinese".tr()),
                                onTap: () {
                                  context.setLocale(Locale('zh'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("hindi".tr()),
                                onTap: () {
                                  context.setLocale(Locale('hi'));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Home()),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ),
                    );
                  }
                );
              }
            )
          ],
        ),
      );
  }

  void showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('contact'.tr()),
          content: Text("worldlotto52@gmail.com"),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showRewardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('reward'.tr()),
          content: Text("watchAds".tr()),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                helperFunctions.createRewardedAds(context);
              },
            ),
            TextButton(
              child: Text('no'.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void showAccountDeleteDialog(BuildContext context, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('deleteAccount'.tr()),
          content: Text("askDeleteAccount".tr()),
          actions: <Widget>[
            TextButton(
              child: Text('yes'.tr()),
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                DeletedAccounts deletedAccounts = DeletedAccounts.instance;
                try {
                  await deletedAccounts.savingeDeletedData(uid);
                  await user?.delete();
                  await helperFunctions.saveUserLoggedInStatus(false);
                  await helperFunctions.saveUserUIdSF("");
                  await helperFunctions.saveVerifiedSF(false);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
                catch (e) {
                  print(e);
                }
              },
            ),
            TextButton(
              child: Text('no'.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}