import 'package:flutter/material.dart';
import 'package:lottery_kr/widget/item/SmallLotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/SmallLotteryNumberBall.dart';

class LotteryNumberRow extends StatefulWidget {
  final int index;
  final Map<String, List<dynamic>> number;
  final Color backgroundColor;
  final Function(int) removeNumberByIndex;
  const LotteryNumberRow({super.key, required this.index, required this.number, required this.backgroundColor, required this.removeNumberByIndex});

  @override
  State<LotteryNumberRow> createState() => _LotteryNumberRowState();
}

class _LotteryNumberRowState extends State<LotteryNumberRow> {
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
        color: widget.backgroundColor,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Play ${widget.index.toString()}", style: TextStyle(fontSize: screenHeight * 0.018, decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.w700)),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Row(
                    children: List.generate(widget.number["numbers"]!.length, (index) {
                      return SmallLotteryNumberBall(number: widget.number["numbers"]![index]);
                    }),
                  ),
                  Row(
                    children: List.generate(widget.number["bonus"]!.length, (index) {
                      return SmallLotteryBonusBall(number: widget.number["numbers"]![index]);
                    }),
                  ),
                  widget.number["reintegro"] == null ?
                  Container()
                  : 
                  Row(
                    children: List.generate(widget.number["reintegro"]!.length, (index) {
                      return SmallLotteryBonusBall(number: widget.number["reintegro"]![index]);
                    }),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
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
                    
                  }, 
                  icon: Icon(Icons.analytics_outlined, color: Colors.black, size: screenWidth * 0.055)
                ),
              ),
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