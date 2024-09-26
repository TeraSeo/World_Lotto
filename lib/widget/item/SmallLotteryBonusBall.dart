import 'package:flutter/material.dart';

class SmallLotteryBonusBall extends StatefulWidget {
  final dynamic number;
  const SmallLotteryBonusBall({super.key, required this.number});

  @override
  State<SmallLotteryBonusBall> createState() => _SmallLotteryBonusBallState();
}

class _SmallLotteryBonusBallState extends State<SmallLotteryBonusBall> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: screenHeight * 0.03,
      height: screenHeight * 0.03,
      margin: EdgeInsets.only(right: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white, 
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
          color: Colors.white,
          decoration: TextDecoration.none
        ),
      ),
    );
  }
}
