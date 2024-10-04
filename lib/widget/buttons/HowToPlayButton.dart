import 'package:flutter/material.dart'; 
import 'package:lottery_kr/widget/LotteryInfoSpecific.dart';
import 'package:easy_localization/easy_localization.dart';

class HowToPlayButton extends StatefulWidget {
  final Map<String, dynamic> lotteryData;
  const HowToPlayButton({super.key, required this.lotteryData});

  @override
  State<HowToPlayButton> createState() => _HowToPlayButtonState();
}

class _HowToPlayButtonState extends State<HowToPlayButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight * 0.045,
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: widget.lotteryData["buttonColor"],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: Offset(3, 6),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LotteryInfoSpecific(lotteryDetails: widget.lotteryData)),
          );
        },
        child: Row(
          children: [
            Icon(Icons.info_outline, size: screenWidth * 0.041, color: Colors.white),
            SizedBox(width: screenWidth * 0.015),
            Text("howToPlay".tr(), style: TextStyle(fontSize: screenWidth * 0.029, fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ),
      )
    );
  }
}