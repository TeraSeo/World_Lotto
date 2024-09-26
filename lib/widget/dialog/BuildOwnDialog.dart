import 'package:flutter/material.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/LotteryReintegro.dart';
import 'package:lottery_kr/widget/item/MostWorstShownNumbersTable.dart';

class BuildOwnDialog {
  Future<Map<String, List<int>>> showBuildOwnNumberDialog(
    BuildContext context, Map<String, dynamic> lotteryDetails, Function(int) addNormalNumber, Function(int) addBonusNumber, Function(int) addReintegroNumber, List<int> numbers, List<int> bonusNumbers, List<int> geintegroNumbers, Function(bool) setIsOnNormal, Function(bool) setIsOnBonus, Function(bool) setIsOnReintegro, bool isOnNormal, {bool? isOnBonus, bool? isOnReintegro} 
  ) async {
    NumberGenerateService numberGenerateService = NumberGenerateService();
    int numberBallCount = numberGenerateService.getNumberOfBalls(lotteryDetails["dbTitle"]);

    Map<String, List<int>> result = {};

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero, // Remove default padding
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.cancel_outlined, color: Colors.white,))
                ],
              ),
              Container(margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025), child: MostWorstShownNumbersTable(lotteryData: lotteryDetails)),
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: Container(
                  width: screenWidth, // Full width of the screen
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: lotteryDetails["color"],
                      tileMode: TileMode.mirror,
                    ),
                    borderRadius: BorderRadius.circular(20), 
                  ),
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                  child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: lotteryDetails["dialogTopColor"],
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20), 
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5, bottom: 2),
                                    child: Text(
                                      "Play",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: screenHeight * 0.025,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Your Current Selection",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenHeight * 0.021,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: List.generate(5, (index) {
                                            return LotteryNumberBall(number: "");
                                          }),
                                        ),
                                        Row(
                                          children: List.generate(1, (index) {
                                            return LotteryBonusBall(number: "");
                                          }),
                                        ),
                                        Row(
                                          children: List.generate(1, (index) {
                                            return LotteryReintegroBall(number: "");
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7, 
                                crossAxisSpacing: 10,
                              ),
                              itemCount: numberBallCount,
                              shrinkWrap: true, // Shrink to fit
                              itemBuilder: (context, index) {
                                return LotteryNumberBall(number: "${index + 1}");
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: lotteryDetails["dialogButtonColor"],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          height: screenHeight * 0.07,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: 
                          isOnNormal ?
                          MaterialButton(
                            onPressed: () {
                              setIsOnNormal(false);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Select Numbers", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            )
                          ) :
                          MaterialButton(
                            onPressed: () {
                              setIsOnBonus(false);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Select Bonus Number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            )
                          )
                        )
                      ],
                    ),
                )
              )
            ],
          ),
        );
      },
    );
    return result;
  }
}
