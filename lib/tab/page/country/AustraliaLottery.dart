import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfo.dart';
import 'package:lottery_kr/tab/page/widget/LotteryMethod.dart';

class AustraliaLottery extends StatefulWidget {
  const AustraliaLottery({super.key});

  @override
  State<AustraliaLottery> createState() => _AustraliaLotteryState();
}

class _AustraliaLotteryState extends State<AustraliaLottery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Text(
                "Australia Powerball",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              SizedBox(height: 10,),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "australiaPowerballInfo.title".tr(),
                  "highestPrize": "australiaPowerballInfo.highestPrize".tr(),
                  "frequency": "australiaPowerballInfo.frequency".tr(),
                  "ticketPrice": "australiaPowerballInfo.ticketPrice".tr(),
                  "drawDate": "australiaPowerballInfo.drawDate".tr(),
                  "purchasableArea": "australiaPowerballInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("australiaPowerballInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("australiaPowerballInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("australiaPowerballInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "ausPowerBallProcess".tr(),
                methods: List<String>.from("australiaPowerballMethods".tr().split('^')),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                   backgroundColor: Colors.grey[850],
                   padding: EdgeInsets.symmetric(horizontal: 100)
                ),
                child: Text(
                  "pickNumber".tr(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "ausPowerBallNumber")),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}