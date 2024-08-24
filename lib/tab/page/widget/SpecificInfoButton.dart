import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfoSpecific.dart';

class SpecificButton extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  const SpecificButton({super.key, required this.lotteryDetails});

  @override
  State<SpecificButton> createState() => _SpecificButtonState();
}

class _SpecificButtonState extends State<SpecificButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 12.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LotteryInfoSpecific(lotteryDetails: widget.lotteryDetails)),
        );
      },
      child: Text(
        "seeDetails".tr(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}