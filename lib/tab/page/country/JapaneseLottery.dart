import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfo.dart';
import 'package:lottery_kr/tab/page/widget/LotteryMethod.dart';

class JapaneseLottery extends StatefulWidget {
  const JapaneseLottery({super.key});

  @override
  State<JapaneseLottery> createState() => _JapaneseLotteryState();
}

class _JapaneseLotteryState extends State<JapaneseLottery> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Text(
                "Lotto 6",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "japaneseLottery6Info.title".tr(),
                  "highestPrize": "japaneseLottery6Info.highestPrize".tr(),
                  "frequency": "japaneseLottery6Info.frequency".tr(),
                  "ticketPrice": "japaneseLottery6Info.ticketPrice".tr(),
                  "drawDate": "japaneseLottery6Info.drawDate".tr(),
                  "purchasableArea": "japaneseLottery6Info.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("japaneseLottery6Info.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("japaneseLottery6Info.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("japaneseLottery6Info.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "jLottoProcess_1".tr(),
                methods: List<String>.from("japaneseLottery6Methods".tr().split('^')),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  padding: EdgeInsets.symmetric(horizontal: 100),
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
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "jLottoNumber_1")),
                  );
                },
              ),
              SizedBox(height: 60),
              Text(
                "Lotto 7",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "japaneseLottery7Info.title".tr(),
                  "highestPrize": "japaneseLottery7Info.highestPrize".tr(),
                  "frequency": "japaneseLottery7Info.frequency".tr(),
                  "ticketPrice": "japaneseLottery7Info.ticketPrice".tr(),
                  "drawDate": "japaneseLottery7Info.drawDate".tr(),
                  "purchasableArea": "japaneseLottery7Info.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("japaneseLottery7Info.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("japaneseLottery7Info.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("japaneseLottery7Info.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "jLottoProcess_2".tr(),
                methods: List<String>.from("japaneseLottery7Methods".tr().split('^')),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  padding: EdgeInsets.symmetric(horizontal: 100),
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
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "jLottoNumber_2")),
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