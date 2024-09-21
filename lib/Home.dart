import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/service/JackpotService.dart';
import 'package:lottery_kr/service/NotificationService.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/widget/LotteryList.dart';
import 'package:lottery_kr/widget/Widget.dart';
import 'package:lottery_kr/widget/buttons/LotteryHomeButton.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedTab = 'USA';
  String dropdownValue = 'usa'.tr();
  List<String> items = ["usa".tr(), "eu".tr(), "uk".tr(), "spain".tr(), "italy".tr(), "aus".tr(), "korea".tr(), "japan".tr()];
  CommonWidget commonWidget = CommonWidget.instance;
  HelperFunctions helperFunctions = HelperFunctions();

  Future<bool> _onWillPop() async {
    return false;
  }
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) async {
      await Permission.notification.request();
      await Permission.scheduleExactAlarm.request();
      bool isNotificationGranted = await Permission.notification.status.isGranted;
      bool isAlarmGranted = await Permission.scheduleExactAlarm.status.isGranted;
      if (isNotificationGranted && isAlarmGranted) {
        await NotificationService.instance.initNotification();
        await JackpoService.instance.getJackpotList().then((value) {
          if (value != null) {
            NotificationService.instance.showAllNotifications(value);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: commonWidget.homeDrawerWidget(context),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromARGB(255, 107, 59, 202),
                Color.fromARGB(255, 221, 81, 228),
                Color.fromARGB(255, 230, 119, 198),
                Color.fromARGB(255, 216, 97, 147),
                Color.fromARGB(255, 233, 105, 124),
                Color.fromARGB(255, 211, 142, 133),
                Color.fromARGB(255, 238, 172, 139),
                Color.fromARGB(255, 232, 188, 144),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: dropdownButton()
                    ),
                  ],
                ),
                LotteryList(selectedTab: _selectedTab),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LotteryHomeButton(buttonText: "Number Analysis", subText: "Analyze your numbers", icon: Icon(Icons.analytics), goToPage: () => helperFunctions.goToResult(context)),
                          LotteryHomeButton(buttonText: "Go to Compare Lotto", subText: "Compare various lotteries", icon: Icon(Icons.compare_arrows), goToPage: () => helperFunctions.goToCompare(context)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LotteryHomeButton(buttonText: "Go to Discussion", subText: "Share lottery tips", icon: Icon(Icons.people), goToPage: () => helperFunctions.goToDiscussion(context))
                        ],
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        )
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

  Widget dropdownButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          _selectedTab,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                ))
            .toList(),
        value: dropdownValue,
        onChanged: (String? value) {
          setState(() {
            if (value == 'usa'.tr()) {
              _selectedTab = 'USA';
              dropdownValue = value!;
            }
            else if (value == 'eu'.tr()) {
              _selectedTab = 'EU';
              dropdownValue = value!;
            }
            else if (value == 'uk'.tr()) {
              _selectedTab = 'UK';
              dropdownValue = value!;
            }
            else if (value == 'spain'.tr()) {
              _selectedTab = 'Spain';
              dropdownValue = value!;
            }
            else if (value == 'italy'.tr()) {
              _selectedTab = 'Italy';
              dropdownValue = value!;
            }
            else if (value == 'aus'.tr()) {
              _selectedTab = 'Australia';
              dropdownValue = value!;
            }
            else if (value == 'korea'.tr()) {
              _selectedTab = 'Korea';
              dropdownValue = value!;
            }
            else if (value == 'japan'.tr()) {
              _selectedTab = 'Japan';
              dropdownValue = value!;
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          width: 160,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromARGB(255, 221, 81, 228),
                Color.fromARGB(255, 230, 119, 198),
                Color.fromARGB(255, 216, 97, 147),
                Color.fromARGB(255, 233, 105, 124),
              ],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(2, 4),
              ),
            ],
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
        ),
        iconStyleData: IconStyleData(iconEnabledColor: Colors.black),
        dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromARGB(255, 221, 81, 228),
                Color.fromARGB(255, 230, 119, 198),
                Color.fromARGB(255, 216, 97, 147),
                Color.fromARGB(255, 233, 105, 124),
              ],
              tileMode: TileMode.mirror,
            ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
        ))
      ),
    );
  }
}
