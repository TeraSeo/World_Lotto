import 'package:flutter/material.dart';

class BuildOwnReintegroGenerator extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  final List<dynamic> bonusNumbers;
  const BuildOwnReintegroGenerator({super.key, required this.lotteryDetails, required this.lotteryData, required this.bonusNumbers});

  @override
  State<BuildOwnReintegroGenerator> createState() => _BuildOwnReintegroGeneratorState();
}

class _BuildOwnReintegroGeneratorState extends State<BuildOwnReintegroGenerator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}