import 'package:flutter/material.dart';
import 'package:lottery_kr/model/HistoryResult.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/NumberHistoryRow.dart';
import 'package:lottery_kr/widget/texts/LotteryCardTitleText.dart';
import 'package:lottery_kr/widget/texts/PrizeStatusText.dart';
import 'package:easy_localization/easy_localization.dart';

class NumberHistory extends StatefulWidget {
  final List<HistoryResult> historyResults;
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  final Map<String, List<dynamic>> selectedNumber;
  final List<dynamic> prizes;
  const NumberHistory({super.key, required this.historyResults, required this.lotteryDetails, required this.lotteryData, required this.selectedNumber, required this.prizes});

  @override
  State<NumberHistory> createState() => _NumberHistoryState();
}

class _NumberHistoryState extends State<NumberHistory> {

  String historyRange = "";
  
  @override
  void initState() {
    super.initState();
    if (widget.lotteryDetails["lottoName"] == "Powerball") {
      setState(() {
        historyRange = "(2020 - 2024)";
      });
    }
    else if (widget.lotteryDetails["lottoName"] == "MegaMillions") {
      setState(() {
        historyRange = "(2020 - 2024)";
      });
    }
    else if (widget.lotteryDetails["lottoName"] == "Euromillon") {
      setState(() {
        historyRange = "(2004 - 2024)";
      });
    }
    else if (widget.lotteryDetails["lottoName"] == "AU Powerball") {
      setState(() {
        historyRange = "(2018 - 2024)";
      });
    }
    else if (widget.lotteryDetails["lottoName"] == "Lotto 6/45") {
      setState(() {
        historyRange = "(2002 - 2024)";
      });
    }
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
          right: screenWidth * 0.05
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
            SizedBox(
              child: Row(
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
            ),
            SizedBox(height: screenHeight * 0.015),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.006),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LotteryCardTitleText(title: widget.lotteryDetails["lottoName"]),
                  PrizeStatusText(date: widget.lotteryData["nextDate"], prize: widget.lotteryData["jackpot"])
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              height: screenHeight * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: widget.lotteryDetails["buttonColor"],
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("selectedNumber".tr(), style: TextStyle(fontSize: 15, color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.w700)),
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
                                    widget.selectedNumber["numbers"]!.length, 
                                    (i) {
                                      return LotteryNumberBall(number: widget.selectedNumber["numbers"]![i]);
                                    },
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    widget.selectedNumber["bonus"]!.length, 
                                    (i) {
                                      return LotteryBonusBall(number: widget.selectedNumber["bonus"]![i]);
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
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: screenWidth * 0.02),
                Text("numberHistory".tr() + " $historyRange:", style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: screenHeight * 0.017, fontWeight: FontWeight.w700))
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: 
                  widget.historyResults.length > 30 ?
                  List.generate(30, (index) {
                    return NumberHistoryRow(lotteryDetails: widget.lotteryDetails, historyResult: widget.historyResults[index], prizes: widget.prizes);
                  }) 
                  : 
                  List.generate(widget.historyResults.length, (index) {
                    return NumberHistoryRow(lotteryDetails: widget.lotteryDetails, historyResult: widget.historyResults[index], prizes: widget.prizes);
                  })
                ),
              )
            ),
          ],
        ),
      )
    );
  }
}