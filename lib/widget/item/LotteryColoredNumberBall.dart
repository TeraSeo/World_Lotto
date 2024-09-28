import 'package:flutter/material.dart';

class LotteryColoredNumberBall extends StatefulWidget {
  final dynamic number;
  const LotteryColoredNumberBall({super.key, required this.number});

  @override
  State<LotteryColoredNumberBall> createState() => _LotteryColoredNumberBallState();
}

class _LotteryColoredNumberBallState extends State<LotteryColoredNumberBall> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      width: screenWidth * 0.09,
      height: screenWidth * 0.09,
      margin: EdgeInsets.only(right: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black, 
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(2, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        widget.number.toString(), 
        style: TextStyle(
          fontSize: screenHeight * 0.015, 
          fontWeight: FontWeight.bold, 
          decoration: TextDecoration.none,
          color: Colors.white
        ),
      ),
    );
  }
}
