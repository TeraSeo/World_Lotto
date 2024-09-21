import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/widget/LotteryInfo.dart';
import 'package:lottery_kr/widget/LotteryMethod.dart';

class AmericanLottery extends StatefulWidget {
  const AmericanLottery({super.key});

  @override
  State<AmericanLottery> createState() => _AmericanLotteryState();
}

class _AmericanLotteryState extends State<AmericanLottery> {

  @override
  Widget build(BuildContext context) {
    // print("americanLotteryInfo.winningMethods".tr);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Text(
                "Powerball",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              LotteryInfoCard(
                // lotteryDetails: americanLotteryInfo
                lotteryDetails: {
                  "title": "americanLotteryInfo.title".tr(),
                  "highestPrize": "americanLotteryInfo.highestPrize".tr(),
                  "frequency": "americanLotteryInfo.frequency".tr(),
                  "ticketPrice": "americanLotteryInfo.ticketPrice".tr(),
                  "drawDate": "americanLotteryInfo.drawDate".tr(),
                  "purchasableArea": "americanLotteryInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("americanLotteryInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("americanLotteryInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("americanLotteryInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: tr("usPowerBallProcess"),
                methods: List<String>.from("americanLotteryMethods".tr().split('^')),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  padding: EdgeInsets.symmetric(horizontal: 100),
                ),
                child: Text(
                  tr("pickNumber"),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ), 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "usPowerballNumber")),
                  );
                },
              ),
              SizedBox(height: 60),
              Text(
                "Megamillion",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              LotteryInfoCard(
                // lotteryDetails: megaMillionsInfo
                lotteryDetails: {
                  "title": "megaMillionsInfo.title".tr(),
                  "highestPrize": "megaMillionsInfo.highestPrize".tr(),
                  "frequency": "megaMillionsInfo.frequency".tr(),
                  "ticketPrice": "megaMillionsInfo.ticketPrice".tr(),
                  "drawDate": "megaMillionsInfo.drawDate".tr(),
                  "purchasableArea": "megaMillionsInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("megaMillionsInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("megaMillionsInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("megaMillionsInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: tr("megaMillionProcess"),
                methods: List<String>.from("megaMillionsMethods".tr().split('^')),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  padding: EdgeInsets.symmetric(horizontal: 100),
                ),
                child: Text(
                  tr("pickNumber"),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "megaMillionNumber")),
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
