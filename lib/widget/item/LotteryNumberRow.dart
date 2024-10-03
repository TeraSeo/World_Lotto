import 'package:flutter/material.dart';
import 'package:lottery_kr/page/history/NumberHistory.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/widget/item/SmallLotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/SmallLotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/SmallReintegro.dart';

class LotteryNumberRow extends StatefulWidget {
  final int index;
  final Map<String, List<dynamic>> number;
  final Function(int) removeNumberByIndex;
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  const LotteryNumberRow({super.key, required this.index, required this.number, required this.removeNumberByIndex, required this.lotteryDetails, required this.lotteryData});

  @override
  State<LotteryNumberRow> createState() => _LotteryNumberRowState();
}

class _LotteryNumberRowState extends State<LotteryNumberRow> {
  LotteryService lotteryService = LotteryService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    
    return Container(
      width: screenWidth,
      height: screenHeight * 0.09,
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
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Play ${widget.index.toString()}", style: TextStyle(fontSize: screenHeight * 0.018, decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.w700)),
                SizedBox(height: screenHeight * 0.005),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Row(
                        children: List.generate(widget.number["numbers"]!.length, (index) {
                          return SmallLotteryNumberBall(number: widget.number["numbers"]![index]);
                        }),
                      ),
                      Row(
                        children: List.generate(widget.number["bonus"]!.length, (index) {
                          if (widget.lotteryDetails["lottoName"] == "La Primitiva") {
                            return SmallReintegro(number: widget.number["bonus"]![index]);
                          }
                          return SmallLotteryBonusBall(number: widget.number["bonus"]![index]);
                        }),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          Row(
            children: [
              widget.lotteryDetails["lottoName"] == "Powerball" || widget.lotteryDetails["lottoName"] == "MegaMillions" || widget.lotteryDetails["lottoName"] == "Euromillon" || widget.lotteryDetails["lottoName"] == "AU Powerball" ?
              Container(
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      offset: Offset(3, 6),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    List<dynamic> numbers = [];
                    numbers.addAll(widget.number["numbers"]!);
                    numbers.addAll(widget.number["bonus"]!);
                    List<dynamic> prizes = widget.lotteryDetails['prizeDetails'];
                    lotteryService.analyzeNumberByLottoName(widget.lotteryDetails["lottoName"], numbers).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NumberHistory(historyResults: value, lotteryDetails: widget.lotteryDetails, lotteryData: widget.lotteryData, selectedNumber: widget.number, prizes: prizes)),
                      );
                    });
                  }, 
                  icon: Icon(Icons.analytics_outlined, color: Colors.black, size: screenWidth * 0.055)
                ),
              ) 
              :
              Container(),
              SizedBox(width: screenWidth * 0.02),
              Container(
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      offset: Offset(3, 6),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    widget.removeNumberByIndex(widget.index - 1);
                  }, 
                  icon: Icon(Icons.delete, color: Colors.red, size: screenWidth * 0.055)
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}