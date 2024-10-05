import 'package:flutter/material.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/widget/buttons/HowToPlayButton.dart';
import 'package:lottery_kr/widget/buttons/NumberGenerateNavigateButton.dart';
import 'package:lottery_kr/widget/texts/LastNumberText.dart';
import 'package:lottery_kr/widget/texts/LotteryCardTitleText.dart';
import 'package:lottery_kr/widget/texts/PrizeStatusText.dart';

class LotteryCard extends StatefulWidget {
  final Map<String, dynamic> lotteryData;

  const LotteryCard({super.key, required this.lotteryData});

  @override
  State<LotteryCard> createState() => _LotteryCardState();
}

class _LotteryCardState extends State<LotteryCard> {
  LotteryService lotteryService = LotteryService();

  Map<String, dynamic>? lotteryData;

  List<List<dynamic>> numbers = [];

  bool isDataLoading = true;

  @override
  void initState() {
    super.initState();
    getLottoData();
  }

  @override
  void didUpdateWidget(covariant LotteryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lotteryData != oldWidget.lotteryData) {
      getLottoData();
    }
  }

  Future getLottoData() async {
    try {
      setState(() {
        isDataLoading = true;
      });
      var value = await lotteryService.getLotteryData(widget.lotteryData["dbTitle"]);
      setState(() {
        lotteryData = value;
        numbers = lotteryService.getSeparatedNumberAndBonus(lotteryData!["number"], widget.lotteryData["dbTitle"]);
        isDataLoading = false;
      });
    } catch (e) {
      setState(() {
        isDataLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      width: screenWidth * 0.92,
      // height: screenHeight * 0.28,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: widget.lotteryData["color"], 
          center: Alignment.center, 
          radius: 1.2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 1),
        ],
      ),
      margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: lotteryData == null || isDataLoading ?
      Center(child: CircularProgressIndicator()) :
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LotteryCardTitleText(title: widget.lotteryData["lottoName"]),
                PrizeStatusText(date: lotteryData!["nextDate"], prize: lotteryData!["jackpot"])
              ],
            ),
          ),
          LastNumberText(lastDay: lotteryData!["lastDate"], numbers: numbers),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HowToPlayButton(lotteryData: widget.lotteryData),
              NumberGenerateNavigateButton(lotteryData: lotteryData!, lotteryDetails: widget.lotteryData)
            ],
          )
        ],
      ),
    );
  }
}
