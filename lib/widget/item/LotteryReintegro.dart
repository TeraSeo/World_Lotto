import 'package:flutter/material.dart';

class LotteryReintegroBall extends StatefulWidget {
  final dynamic number;
  const LotteryReintegroBall({super.key, required this.number});

  @override
  State<LotteryReintegroBall> createState() => _LotteryReintegroBallState();
}

class _LotteryReintegroBallState extends State<LotteryReintegroBall> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: screenHeight * 0.04,
      height: screenHeight * 0.04,
      margin: EdgeInsets.only(right: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.green,
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
          color: Colors.white 
        ),
      ),
    );
  }
}
