import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfo.dart';
import 'package:lottery_kr/tab/page/widget/LotteryMethod.dart';

class EuroLottery extends StatefulWidget {
  const EuroLottery({super.key});

  @override
  State<EuroLottery> createState() => _EuroLotteryState();
}

class _EuroLotteryState extends State<EuroLottery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Text(
                "EuroMillions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              SizedBox(height: 10,),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "euroMillionsInfo.title".tr(),
                  "highestPrize": "euroMillionsInfo.highestPrize".tr(),
                  "frequency": "euroMillionsInfo.frequency".tr(),
                  "ticketPrice": "euroMillionsInfo.ticketPrice".tr(),
                  "drawDate": "euroMillionsInfo.drawDate".tr(),
                  "purchasableArea": "euroMillionsInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("euroMillionsInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("euroMillionsInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("euroMillionsInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "euroMillionProcess".tr(),
                methods: List<String>.from("euroMillionsMethods".tr().split('^')),
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
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "euroMillionNumber")),
                  );
                },
              ),
              SizedBox(height: 60),
              Text(
                "Eurojackpot",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              SizedBox(height: 10,),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "euroJackpotInfo.title".tr(),
                  "highestPrize": "euroJackpotInfo.highestPrize".tr(),
                  "frequency": "euroJackpotInfo.frequency".tr(),
                  "ticketPrice": "euroJackpotInfo.ticketPrice".tr(),
                  "drawDate": "euroJackpotInfo.drawDate".tr(),
                  "purchasableArea": "euroJackpotInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("euroJackpotInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("euroJackpotInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("euroJackpotInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "euroJackpotProcess".tr(),
                methods: List<String>.from("euroJackpotMethods".tr().split('^')),
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
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "euroJackpotNumber")),
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
