import 'package:flutter/material.dart';

class SmallLotteryNumberBall extends StatefulWidget {
  final dynamic number;
  const SmallLotteryNumberBall({super.key, required this.number});

  @override
  State<SmallLotteryNumberBall> createState() => _SmallLotteryNumberBallState();
}

class _SmallLotteryNumberBallState extends State<SmallLotteryNumberBall> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: screenHeight * 0.03,
      height: screenHeight * 0.03,
      margin: EdgeInsets.only(right: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
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
          color: Colors.black
        ),
      ),
    );
  }
}
