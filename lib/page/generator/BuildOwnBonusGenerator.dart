import 'package:flutter/material.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/LotteryReintegro.dart';
import 'package:lottery_kr/widget/item/MostWorstShownNumbersTable.dart';

class BuildOwnBonusGenerator extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  final List<dynamic> numbers;
  const BuildOwnBonusGenerator({super.key, required this.lotteryDetails, required this.lotteryData, required this.numbers});

  @override
  State<BuildOwnBonusGenerator> createState() => _BuildOwnBonusGeneratorState();
}

class _BuildOwnBonusGeneratorState extends State<BuildOwnBonusGenerator> {
  int normalNumberCount = 0;
  int bonusNumberCount = 0;
  int reintegroNumberCount = 0;

  NumberGenerateService numberGenerateService = NumberGenerateService();
  LotteryService lotteryService = LotteryService();

  bool isNumbersLoading = true;
  int bonusNumberBallCount = 0;

  List<dynamic> bonusNumbers = [];

  @override
  void initState() {
    super.initState();
    bonusNumberBallCount = numberGenerateService.getBonusNumberOfBalls(widget.lotteryDetails["dbTitle"]);
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
                              "Your Current Selection",
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
                                  Row(
                                    children: List.generate(widget.numbers.length, (index) {
                                      return LotteryNumberBall(number: widget.numbers[index]);
                                    }),
                                  ),
                                  bonusNumbers.length > 0 ?
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(bonusNumbers.length, (index) {
                                          if (widget.lotteryDetails["lottoName"] == "La Primitiva") {
                                            return LotteryReintegroBall(number: bonusNumbers[index]);
                                          }
                                          return LotteryBonusBall(number: bonusNumbers[index]);
                                        }),
                                      ),
                                      Row(
                                        children: List.generate(bonusNumberCount - bonusNumbers.length, (index) {
                                          if (widget.lotteryDetails["lottoName"] == "La Primitiva") {
                                            return LotteryReintegroBall(number: "");
                                          }
                                          return LotteryBonusBall(number: "");
                                        }),
                                      )
                                    ],
                                  ) :
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
                              ...List.generate((bonusNumberBallCount / 7).floor(), (rowIndex) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(7, (colIndex) {
                                    int number = rowIndex * 7 + colIndex + 1;
                                    return GestureDetector(
                                      onTap: () {
                                        if (!bonusNumbers.contains(number) && bonusNumbers.length < bonusNumberCount) {
                                          setState(() {
                                            bonusNumbers.add(number);
                                          });
                                        }
                                        else {
                                          setState(() {
                                            bonusNumbers.remove(number);
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                        child: bonusNumbers.contains(number) ? widget.lotteryDetails["lottoName"] == "La Primitiva" ? LotteryReintegroBall(number: "$number") : LotteryBonusBall(number: "$number") : LotteryNumberBall(number: "$number"),
                                      ),
                                    );
                                  }),
                                );
                              }),
                              if (bonusNumberBallCount % 7 != 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(bonusNumberBallCount % 7, (index) {
                                    int number = (bonusNumberBallCount / 7).floor() * 7 + index + 1;
                                    return GestureDetector(
                                      onTap: () {
                                        if (!bonusNumbers.contains(number) && bonusNumbers.length < bonusNumberCount) {
                                          setState(() {
                                            bonusNumbers.add(number);
                                          });
                                        }
                                        else {
                                          setState(() {
                                            bonusNumbers.remove(number);
                                          });
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                        child: bonusNumbers.contains(number) ? widget.lotteryDetails["lottoName"] == "La Primitiva" ? LotteryReintegroBall(number: "$number") : LotteryBonusBall(number: "$number") : LotteryNumberBall(number: "$number"),
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
                        onPressed: () {
                          if (bonusNumbers.length == bonusNumberCount) {
                            widget.numbers.sort((a, b) => a.compareTo(b));
                            Map<String, List<dynamic>> number = {'numbers': widget.numbers, 'bonus': bonusNumbers, 'reintegro': []};
                            lotteryService.saveSeparateNumber(widget.lotteryDetails["lottoName"], number);
                            numberGenerateService.navigateToNumberGeneratorPageNResetToHome(widget.lotteryDetails, widget.lotteryData, context);
                          } 
                        },
                        child: 
                        reintegroNumberCount > 0 ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.lotteryDetails["reintegroNumberText"],
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
                              "Generate Number",
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
