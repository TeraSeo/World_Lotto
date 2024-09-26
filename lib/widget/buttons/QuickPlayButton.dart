import 'package:flutter/material.dart';

class QuickPlayButton extends StatefulWidget {
  final Color buttonColor;
  final VoidCallback setQuickPlayTrue;
  const QuickPlayButton({super.key, required this.buttonColor, required this.setQuickPlayTrue});

  @override
  State<QuickPlayButton> createState() => _QuickPlayButtonState();
}

class _QuickPlayButtonState extends State<QuickPlayButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight * 0.08,
      width: screenWidth * 0.44,
      margin: EdgeInsets.only(top: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: widget.buttonColor,
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
          widget.setQuickPlayTrue();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shuffle, color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Quick Play", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
              ],
            )
          ],
        )
      )
    );
  }
}