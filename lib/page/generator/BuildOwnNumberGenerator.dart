import 'package:flutter/material.dart';
import 'package:lottery_kr/page/generator/BuildOwnBonusGenerator.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryColoredNumberBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/LotteryReintegro.dart';
import 'package:lottery_kr/widget/item/MostWorstShownNumbersTable.dart';
import 'package:easy_localization/easy_localization.dart';

class BuildOwnNumberGenerator extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  const BuildOwnNumberGenerator({super.key, required this.lotteryDetails, required this.lotteryData});

  @override
  State<BuildOwnNumberGenerator> createState() => _BuildOwnNumberGeneratorState();
}

class _BuildOwnNumberGeneratorState extends State<BuildOwnNumberGenerator> {
  int normalNumberCount = 0;
  int bonusNumberCount = 0;
  int reintegroNumberCount = 0;

  NumberGenerateService numberGenerateService = NumberGenerateService();
  LotteryService lotteryService = LotteryService();

  bool isNumbersLoading = true;
  int numberBallCount = 0;

  List<dynamic> numbers = [];

  @override
  void initState() {
    super.initState();
    numberBallCount = numberGenerateService.getNumberOfBalls(widget.lotteryDetails["dbTitle"]);
    normalNumberCount = widget.lotteryDetails["normalNumberCount"];
    bonusNumberCount= widget.lotteryDetails["bonusNumberCount"];
    reintegroNumberCount = widget.lotteryDetails["reintegroNumberCount"];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        padding: EdgeInsets.only(
          top: screenHeight * 0.08,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: widget.lotteryDetails["color"],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: screenHeight * 0.03, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            MostWorstShownNumbersTable(lotteryData: widget.lotteryDetails),
            SizedBox(height: screenHeight * 0.01),
            Expanded(
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: widget.lotteryDetails["color"],
                    tileMode: TileMode.mirror,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: widget.lotteryDetails["dialogTopColor"],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              "currentSelection".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: screenHeight * 0.021,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  numbers.length > 0 ?
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(numbers.length, (index) {
                                          return LotteryNumberBall(number: numbers[index]);
                                        }),
                                      ),
                                      Row(
                                        children: List.generate(normalNumberCount - numbers.length, (index) {
                                          return LotteryNumberBall(number: "");
                                        }),
                                      )
                                    ],
                                  )
                                  :
                                  Row(
                                    children: List.generate(normalNumberCount, (index) {
                                      return LotteryNumberBall(number: "");
                                    }),
                                  ),
                                  Row(
                                    children: List.generate(bonusNumberCount, (index) {
                                      if (widget.lotteryDetails["lottoName"] == "La Primitiva") {
                                        return LotteryReintegroBall(number: "");
                                      }
                                      return LotteryBonusBall(number: "");
                                    }),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.015),
                              ...List.generate((numberBallCount / 7).floor(), (rowIndex) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(7, (colIndex) {
                                    int number = rowIndex * 7 + colIndex + 1;
                                    return GestureDetector(
                                      onTap: () {
                                        if (!numbers.contains(number) && numbers.length < normalNumberCount) {
                                          setState(() {
                                            numbers.add(number);
                                          });
                                        }
                                        else {
                                          setState(() {
                                            numbers.remove(number);
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                        child: numbers.contains(number) ? LotteryColoredNumberBall(number: "$number") : LotteryNumberBall(number: "$number"),
                                      ),
                                    );
                                  }),
                                );
                              }),
                              if (numberBallCount % 7 != 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(numberBallCount % 7, (index) {
                                    int number = (numberBallCount / 7).floor() * 7 + index + 1;
                                    return GestureDetector(
                                      onTap: () {
                                        if (!numbers.contains(number) && numbers.length < normalNumberCount) {
                                          setState(() {
                                            numbers.add(number);
                                          });
                                        }
                                        else {
                                          setState(() {
                                            numbers.remove(number);
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                        child: numbers.contains(number) ? LotteryColoredNumberBall(number: "$number") : LotteryNumberBall(number: "$number"),
                                      ),
                                    );
                                  }),
                                ),
                            ],
                          ),
                        )
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: widget.lotteryDetails["dialogButtonColor"],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      height: screenHeight * 0.07,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: MaterialButton(
                        onPressed: () async {
                          if (numbers.length == normalNumberCount) {
                            if (bonusNumberCount > 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BuildOwnBonusGenerator(lotteryDetails: widget.lotteryDetails, lotteryData: widget.lotteryData, numbers: numbers)),
                              );
                            }
                            else {
                              numbers.sort((a, b) => a.compareTo(b));
                              Map<String, List<dynamic>> number = {'numbers': numbers, 'bonus': [], 'reintegro': []};
                              bool isSaved = await lotteryService.saveSeparateNumber(widget.lotteryDetails["lottoName"], number, context);
                              if (isSaved) numberGenerateService.navigateToNumberGeneratorPageNResetToHome(widget.lotteryDetails, widget.lotteryData, context);
                            }
                          }
                        },
                        child: 
                        bonusNumberCount > 0 ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.lotteryDetails["bonusNumberText"],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ) :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "generateNumber".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}
