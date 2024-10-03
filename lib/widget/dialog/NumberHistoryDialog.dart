import 'package:flutter/material.dart';
import 'package:lottery_kr/model/HistoryResult.dart';
import 'package:lottery_kr/widget/item/NumberHistoryRow.dart';

class NumberHistoryDialog {

  void buildNumberHistoryDialog(BuildContext context, List<HistoryResult> historyResults, Map<String, dynamic> lotteryDetails) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: lotteryDetails["color"],
                tileMode: TileMode.mirror,
              ),
              color: lotteryDetails["backgroundColor"],
              borderRadius: BorderRadius.circular(20), 
            ),
            width: screenWidth,
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: lotteryDetails["dialogTopColor"],
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20), 
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Number History", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: screenHeight * 0.021,
                      ))
                    ],
                  )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(historyResults.length, (index) {
                          return NumberHistoryRow(lotteryDetails: lotteryDetails, historyResult: historyResults[index]);
                        }),
                      ),
                    ),
                  )
                )
              ]
            ),
          )
        );
      }
    );
  }

}