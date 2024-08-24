import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfo.dart';
import 'package:lottery_kr/tab/page/widget/LotteryMethod.dart';

class ItalianLottery extends StatefulWidget {
  const ItalianLottery({super.key});

  @override
  State<ItalianLottery> createState() => _ItalianLotteryState();
}

class _ItalianLotteryState extends State<ItalianLottery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Text(
                "SuperEnalotto",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              SizedBox(height: 10,),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "superEnalottoInfo.title".tr(),
                  "highestPrize": "superEnalottoInfo.highestPrize".tr(),
                  "frequency": "superEnalottoInfo.frequency".tr(),
                  "ticketPrice": "superEnalottoInfo.ticketPrice".tr(),
                  "drawDate": "superEnalottoInfo.drawDate".tr(),
                  "purchasableArea": "superEnalottoInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("superEnalottoInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("superEnalottoInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("superEnalottoInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "superEnalottoProcess".tr(),
                methods: List<String>.from("superEnalottoMethods".tr().split('^')),
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
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "superEnalottoNumber")),
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