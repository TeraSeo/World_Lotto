import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfo.dart';
import 'package:lottery_kr/tab/page/widget/LotteryMethod.dart';

class SpanishLottery extends StatefulWidget {
  const SpanishLottery({super.key});

  @override
  State<SpanishLottery> createState() => _SpanishLotteryState();
}

class _SpanishLotteryState extends State<SpanishLottery> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            child: Column(
              children: [
                Text(
                  "La Primitiva",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                LotteryInfoCard(
                  lotteryDetails: {
                    "title": "spanishLaPrimitivaInfo.title".tr(),
                    "highestPrize": "spanishLaPrimitivaInfo.highestPrize".tr(),
                    "frequency": "spanishLaPrimitivaInfo.frequency".tr(),
                    "ticketPrice": "spanishLaPrimitivaInfo.ticketPrice".tr(),
                    "drawDate": "spanishLaPrimitivaInfo.drawDate".tr(),
                    "purchasableArea": "spanishLaPrimitivaInfo.purchasableArea".tr(),
                    "prizeDetails": List<String>.from("spanishLaPrimitivaInfo.prizeDetails".tr().split('^')),
                    "winningMethods": List<String>.from("spanishLaPrimitivaInfo.winningMethods".tr().split('^')),
                    "probabilities": List<String>.from("spanishLaPrimitivaInfo.probabilities".tr().split('^'))
                  },
                ),
                SizedBox(height: 16),
                LotteryMethodCard(
                  title: "laPrimiticaProcess".tr(),
                  methods: List<String>.from("spanishLaPrimitivaMethods".tr().split('^')),
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
                      MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "laPrimitivaNumber")),
                    );
                  },
                ),
                SizedBox(height: 60),
                Text(
                  "El Gordo(5/54)",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                LotteryInfoCard(
                  lotteryDetails: {
                    "title": "elGordoLotteryInfo.title".tr(),
                    "highestPrize": "elGordoLotteryInfo.highestPrize".tr(),
                    "frequency": "elGordoLotteryInfo.frequency".tr(),
                    "ticketPrice": "elGordoLotteryInfo.ticketPrice".tr(),
                    "drawDate": "elGordoLotteryInfo.drawDate".tr(),
                    "purchasableArea": "elGordoLotteryInfo.purchasableArea".tr(),
                    "prizeDetails": List<String>.from("elGordoLotteryInfo.prizeDetails".tr().split('^')),
                    "winningMethods": List<String>.from("elGordoLotteryInfo.winningMethods".tr().split('^')),
                    "probabilities": List<String>.from("elGordoLotteryInfo.probabilities".tr().split('^'))
                  },
                ),
                SizedBox(height: 16),
                LotteryMethodCard(
                  title: "elGordoProcess".tr(),
                  methods: List<String>.from("elGordoLotteryMethods".tr().split('^')),
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
                      MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "elGordoNumber")),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
