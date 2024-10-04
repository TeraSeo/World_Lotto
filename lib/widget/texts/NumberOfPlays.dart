import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NumberofPlays extends StatefulWidget {
  final int length;
  final Map<String, dynamic> lotteryDetails;
  const NumberofPlays({super.key, required this.length, required this.lotteryDetails});

  @override
  State<NumberofPlays> createState() => _NumberofPlaysState();
}

class _NumberofPlaysState extends State<NumberofPlays> {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    double price = widget.lotteryDetails["price"];
    String currency = widget.lotteryDetails["currency"];
    double totalPrice = price * widget.length;
    String formattedPrice = totalPrice.toStringAsFixed(1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("numberOfPlays".tr() + ": ${widget.length}", style: TextStyle(fontSize: screenHeight * 0.015, decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.w700)),
        SizedBox(width: 10),
        Flexible(child: Text("playCost".tr() + ": $currency$formattedPrice", style: TextStyle(fontSize: screenHeight * 0.015, decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis))
      ],
    );
  }
}