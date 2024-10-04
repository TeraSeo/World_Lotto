import 'package:flutter/material.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/LotteryReintegro.dart';

class LastNumberText extends StatefulWidget {
  final String lastDay;
  final List<List<dynamic>> numbers;
  const LastNumberText({super.key, required this.lastDay, required this.numbers});

  @override
  State<LastNumberText> createState() => _LastNumberTextState();
}

class _LastNumberTextState extends State<LastNumberText> {
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Last - ${widget.lastDay}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: screenWidth * 0.033))
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Row(
                  children: List.generate(
                    widget.numbers[0].length, 
                    (index) {
                      return LotteryNumberBall(number: widget.numbers[0][index]);
                    },
                  ),
                ),
                Row(
                  children: List.generate(
                    widget.numbers[1].length, 
                    (index) {
                      return LotteryBonusBall(number: widget.numbers[1][index]);
                    },
                  ),
                ),
                Row(
                  children: List.generate(
                    widget.numbers[2].length, 
                    (index) {
                      return LotteryReintegroBall(number: widget.numbers[2][index]);
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}