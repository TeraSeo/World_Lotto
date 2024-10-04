import 'package:flutter/material.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:easy_localization/easy_localization.dart';

class NumberGenerateButton extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final VoidCallback generateNumber;
  const NumberGenerateButton({super.key, required this.lotteryDetails, required this.generateNumber});

  @override
  State<NumberGenerateButton> createState() => _NumberGenerateButtonState();
}

class _NumberGenerateButtonState extends State<NumberGenerateButton> {
  NumberGenerateService numberGenerateService = NumberGenerateService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight * 0.055,
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: widget.lotteryDetails["backgroundColor"],
        borderRadius: BorderRadius.circular(25),
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
          widget.generateNumber();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("generateNumber".tr(), style: TextStyle(fontSize: screenWidth * 0.033, fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ),
      )
    );
  }
}