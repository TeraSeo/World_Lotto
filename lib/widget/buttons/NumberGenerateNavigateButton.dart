import 'package:flutter/material.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:easy_localization/easy_localization.dart';

class NumberGenerateNavigateButton extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  const NumberGenerateNavigateButton({super.key, required this.lotteryDetails, required this.lotteryData});

  @override
  State<NumberGenerateNavigateButton> createState() => _NumberGenerateNavigateButtonState();
}

class _NumberGenerateNavigateButtonState extends State<NumberGenerateNavigateButton> {
  NumberGenerateService numberGenerateService = NumberGenerateService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight * 0.045,
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: widget.lotteryDetails["buttonColor"],
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
          numberGenerateService.navigateToNumberGeneratorPage(widget.lotteryDetails, widget.lotteryData, context);
        },
        child: Row(
          children: [
            Icon(Icons.info_outline, size: screenWidth * 0.041, color: Colors.white),
            SizedBox(width: screenWidth * 0.015),
            Text("generateNumber".tr(), style: TextStyle(fontSize: screenWidth * 0.029, fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ),
      )
    );
  }
}