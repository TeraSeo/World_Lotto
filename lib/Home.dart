import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:lottery_kr/service/JackpotService.dart';
import 'package:lottery_kr/service/NotificationService.dart';
import 'package:lottery_kr/tab/LotteryTab.dart';
import 'package:lottery_kr/tab/LotteryTabPage.dart';
import 'package:lottery_kr/widget/Widget.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedTab = 'USA';
  String dropdownValue = 'usa'.tr();
  double _containerHeight = 700;
  List<String> items = ["usa".tr(), "eu".tr(), "uk".tr(), "spain".tr(), "italy".tr(), "aus".tr(), "korea".tr(), "japan".tr()];
  CommonWidget commonWidget = CommonWidget.instance;

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

  // Future<void> _requestCameraPermission() async {
  //   PermissionStatus status = await Permission.camera.status;
  //   if (!status.isGranted) {
  //     status = await Permission.camera.request();
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Device.get().hasNotch) {
      setState(() {
        _containerHeight = MediaQuery.of(context).size.height * 0.60;
      });
    }
    else {
      setState(() {
        _containerHeight = MediaQuery.of(context).size.height * 0.63;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color.fromARGB(133, 59, 89, 179),
        drawer: commonWidget.drawerWidgetWithDropdown(dropdownButton(), context),
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            exit(0);
                          },
                        ),
                      ),
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
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.casino, size: 30, color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "title".tr(),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.11),
                          child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LotteryTab(
                                text: 'usa'.tr(),
                                isSelected: _selectedTab == 'USA',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'USA';
                                  });
                                },
                              ),
                              LotteryTab(
                                text: 'eu'.tr(),
                                isSelected: _selectedTab == 'EU',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'EU';
                                  });
                                },
                              ),
                              LotteryTab(
                                text: 'uk'.tr(),
                                isSelected: _selectedTab == 'UK',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'UK';
                                  });
                                },
                              ),
                              LotteryTab(
                                text: 'spain'.tr(),
                                isSelected: _selectedTab == 'Spain',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'Spain';
                                  });
                                },
                              ),
                              LotteryTab(
                                text: 'italy'.tr(),
                                isSelected: _selectedTab == 'Italy',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'Italy';
                                  });
                                },
                              ),
                              LotteryTab(
                                text: 'aus'.tr(),
                                isSelected: _selectedTab == 'Australia',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'Australia';
                                  });
                                },
                              ),
                              LotteryTab(
                                text: 'korea'.tr(),
                                isSelected: _selectedTab == 'Korea',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'Korea';
                                  });
                                },
                              ),
                              LotteryTab(
                                text: 'japan'.tr(),
                                isSelected: _selectedTab == 'Japan',
                                onTap: () {
                                  setState(() {
                                    _selectedTab = 'Japan';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        setState(() {
                          _containerHeight -= details.primaryDelta!;
                          if (Device.get().hasNotch) {
                            if (_containerHeight < MediaQuery.of(context).size.height * 0.6) {
                              _containerHeight = MediaQuery.of(context).size.height * 0.6;
                            }
                          }
                          else {
                            if (_containerHeight < MediaQuery.of(context).size.height * 0.63) {
                              _containerHeight = MediaQuery.of(context).size.height * 0.63;
                            }
                          }
                          if (_containerHeight > MediaQuery.of(context).size.height - 100) {
                            _containerHeight = MediaQuery.of(context).size.height - 100;
                          }
                        });
                      },
                      child: 
                      Container(
                        height: _containerHeight,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    LotteryTabPage(content: _selectedTab),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
                      color: Colors.black
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
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
