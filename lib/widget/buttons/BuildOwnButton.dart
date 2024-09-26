import 'package:flutter/material.dart';

class BuildOwnButton extends StatefulWidget {
  final Color buttonColor;
  final VoidCallback buildOwnNumber;
  const BuildOwnButton({super.key, required this.buttonColor, required this.buildOwnNumber});

  @override
  State<BuildOwnButton> createState() => _BuildOwnButtonState();
}

class _BuildOwnButtonState extends State<BuildOwnButton> {
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
          widget.buildOwnNumber();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, color: Colors.white),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Select your number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
              ],
            )
          ],
        )
      )
    );
  }
}