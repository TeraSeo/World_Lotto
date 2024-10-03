import 'package:flutter/material.dart';
import 'package:lottery_kr/model/HistoryResult.dart';
import 'package:lottery_kr/widget/item/SmallLotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/SmallLotteryNumberBall.dart';

class NumberHistoryRow extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final HistoryResult historyResult;
  final List<dynamic> prizes;
  const NumberHistoryRow({super.key, required this.lotteryDetails, required this.historyResult, required this.prizes});

  @override
  State<NumberHistoryRow> createState() => _NumberHistoryRowState();
}

class _NumberHistoryRowState extends State<NumberHistoryRow> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: widget.lotteryDetails["backgroundColor"],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: Offset(3, 6),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenHeight * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.historyResult.drawnDate, style: TextStyle(fontSize: 15, color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.w700))
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(widget.historyResult.numbers["numbers"]!.length, (index) {
                    return SmallLotteryNumberBall(number: widget.historyResult.numbers["numbers"]![index]);
                  }),
                ),
                Row(
                  children: List.generate(widget.historyResult.numbers["bonus"]!.length, (index) {
                    return SmallLotteryBonusBall(number: widget.historyResult.numbers["bonus"]![index]);
                  }),
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.prizes[widget.historyResult.rank], style: TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.none, fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}