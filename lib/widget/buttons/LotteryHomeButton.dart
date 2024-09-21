import 'package:flutter/material.dart';

class LotteryHomeButton extends StatefulWidget {
  final String buttonText;
  final String subText;
  final Icon icon;
  final VoidCallback goToPage;
  const LotteryHomeButton({super.key, required this.buttonText, required this.subText, required this.icon, required this.goToPage});

  @override
  State<LotteryHomeButton> createState() => _LotteryHomeButtonState();
}

class _LotteryHomeButtonState extends State<LotteryHomeButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: screenWidth * 0.43,
      height: screenHeight * 0.2,
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.0135),
      decoration: BoxDecoration(
        color: Colors.white,
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
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        onPressed: () {
          widget.goToPage();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey, 
                    shape: BoxShape.circle,
                  ),
                  child: widget.icon,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              widget.buttonText,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black, 
                fontSize: 16,
                fontWeight: FontWeight.bold, 
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              widget.subText,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black, 
                fontSize: 12,
                fontWeight: FontWeight.w300, 
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
