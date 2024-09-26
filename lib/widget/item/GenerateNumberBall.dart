import 'package:flutter/material.dart';

class GenerateNumberBall extends StatefulWidget {
  final dynamic number;
  const GenerateNumberBall({super.key, required this.number});

  @override
  State<GenerateNumberBall> createState() => _GenerateNumberBallState();
}

class _GenerateNumberBallState extends State<GenerateNumberBall> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: screenWidth * 0.085,
      height: screenWidth * 0.085,
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
