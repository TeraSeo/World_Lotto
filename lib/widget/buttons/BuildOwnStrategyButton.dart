import 'package:flutter/material.dart';

class BuildOwnStrategyButton extends StatefulWidget {
  final Color buttonColor;
  const BuildOwnStrategyButton({super.key, required this.buttonColor});

  @override
  State<BuildOwnStrategyButton> createState() => _BuildOwnStrategyButtonState();
}

class _BuildOwnStrategyButtonState extends State<BuildOwnStrategyButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight * 0.08,
      width: screenWidth * 0.28,
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
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.stacked_bar_chart, color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Build your own strategy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
              ],
            )
          ],
        )
      )
    );
  }
}