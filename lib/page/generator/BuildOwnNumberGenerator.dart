import 'package:flutter/material.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/LotteryReintegro.dart';
import 'package:lottery_kr/widget/item/MostWorstShownNumbersTable.dart';

class BuildOwnNumberGenerator extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  const BuildOwnNumberGenerator({super.key, required this.lotteryDetails, required this.lotteryData});

  @override
  State<BuildOwnNumberGenerator> createState() => _BuildOwnNumberGeneratorState();
}

class _BuildOwnNumberGeneratorState extends State<BuildOwnNumberGenerator> {

  NumberGenerateService numberGenerateService = NumberGenerateService();
  bool isNumbersLoading = true;
  int numberBallCount = 0;

  @override
  void initState() {
    super.initState();
    numberBallCount = numberGenerateService.getNumberOfBalls(widget.lotteryDetails["dbTitle"]);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(7, (colIndex) {
                                    int number = rowIndex * 7 + colIndex + 1;
                                    return GestureDetector(
                                      onTap: () {
                                        print(number);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                        child: LotteryNumberBall(number: "$number"),
                                      ),
                                    );
                                  }),
                                );
                              }),
                              if (numberBallCount % 7 != 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(numberBallCount % 7, (index) {
                                    int number = (numberBallCount / 7).floor() * 7 + index + 1;
                                    return GestureDetector(
                                      onTap: () {
                                        print(number);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                        child: LotteryNumberBall(number: "$number"),
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
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select Numbers",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
