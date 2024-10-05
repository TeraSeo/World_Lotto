import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class MostWorstShownNumbersTable extends StatefulWidget {
  final Map<String, dynamic> lotteryData;
  const MostWorstShownNumbersTable({super.key, required this.lotteryData});

  @override
  State<MostWorstShownNumbersTable> createState() => _MostWorstShownNumbersTableState();
}

class _MostWorstShownNumbersTableState extends State<MostWorstShownNumbersTable> {
  late PageController controller;
  LotteryService lotteryService = LotteryService();

  List<String> shownTexts = ["mostCommon".tr(), "worstCommon".tr()];

  bool isOnWifi = false;
  bool isNumbersLoading = true;

  List<List<dynamic>> mostWorstShownNumbers = [];

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 1, keepPage: true);
    Future.delayed(Duration.zero).then((value) async {
      isOnWifi = await InternetConnection().hasInternetAccess;
      if (isOnWifi) {
        await lotteryService.getMostWorstShownNumbers(widget.lotteryData["dbTitle"]).then((value) {
          mostWorstShownNumbers = value;
          if (this.mounted) {
            setState(() {
              isNumbersLoading = false;
            });
          }
        });
      }
      else {
        if (this.mounted) {
          setState(() {
            isNumbersLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return isNumbersLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          SizedBox(
            height: screenHeight * 0.1,
            child: PageView.builder(
              controller: controller,
              itemCount: 2,
              itemBuilder: (_, index) {
                return Container(
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: widget.lotteryData["buttonColor"],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: 
                  isOnWifi ?
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(shownTexts[index], style: TextStyle(fontSize: screenHeight * 0.017, color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Row(
                                children: 
                                  [
                                    Row(
                                      children: List.generate(
                                        mostWorstShownNumbers[index * 2].length, 
                                        (i) {
                                          return LotteryNumberBall(number: int.parse(mostWorstShownNumbers[index * 2][i]));
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        mostWorstShownNumbers[index * 2 + 1].length, 
                                        (i) {
                                          return LotteryBonusBall(number: int.parse(mostWorstShownNumbers[index * 2 + 1][i]));
                                        },
                                      ),
                                    )
                                  ]
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                  :
                  Text("requireWifi".tr())
                );
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.007),
          SmoothPageIndicator(
            controller: controller,
            count: 2,
            effect: const WormEffect(
              dotHeight: 7,
              dotWidth: 7,
              type: WormType.thinUnderground,
              dotColor: Colors.white,
              activeDotColor: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
