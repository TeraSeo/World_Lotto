import 'package:flutter/material.dart';

class LotteryCardTitleText extends StatelessWidget {
  final String title;
  const LotteryCardTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: screenWidth * 0.43,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.063), maxLines: 1)
        ],
      ),
    );
  }
}