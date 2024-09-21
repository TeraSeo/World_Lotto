import 'package:flutter/material.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';

class NumberGenerateButton extends StatefulWidget {
  final Map<String, dynamic> lotteryData;
  const NumberGenerateButton({super.key, required this.lotteryData});

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
          numberGenerateService.navigateToNumberGeneratorPage(widget.lotteryData["dbTitle"], context);
        },
        child: Row(
          children: [
            Icon(Icons.info_outline, size: screenWidth * 0.041, color: Colors.white),
            SizedBox(width: screenWidth * 0.015),
            Text("Generate number", style: TextStyle(fontSize: screenWidth * 0.029, fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ),
      )
    );
  }
}