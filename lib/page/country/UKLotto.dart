import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/widget/LotteryInfo.dart';
import 'package:lottery_kr/widget/LotteryMethod.dart';

class UkLottery extends StatefulWidget {
  const UkLottery({super.key});

  @override
  State<UkLottery> createState() => _UkLotteryState();
}

class _UkLotteryState extends State<UkLottery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Text(
                "UK Lotto",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              SizedBox(height: 10,),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "ukLottoInfo.title".tr(),
                  "highestPrize": "ukLottoInfo.highestPrize".tr(),
                  "frequency": "ukLottoInfo.frequency".tr(),
                  "ticketPrice": "ukLottoInfo.ticketPrice".tr(),
                  "drawDate": "ukLottoInfo.drawDate".tr(),
                  "purchasableArea": "ukLottoInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("ukLottoInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("ukLottoInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("ukLottoInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "ukLottoProcess".tr(),
                methods: List<String>.from("ukLottoMethods".tr().split('^')),
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
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "ukLotto")),
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