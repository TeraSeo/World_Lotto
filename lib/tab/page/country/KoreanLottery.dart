import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/tab/page/generator/NumberGenerator.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfo.dart';
import 'package:lottery_kr/tab/page/widget/LotteryMethod.dart';

class KoreanLottery extends StatefulWidget {
  const KoreanLottery({super.key});

  @override
  State<KoreanLottery> createState() => _KoreanLotteryState();
}

class _KoreanLotteryState extends State<KoreanLottery> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Text(
                "Lotto 6/45",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              SizedBox(height: 10,),
              LotteryInfoCard(
                lotteryDetails: {
                  "title": "koreanLotteryInfo.title".tr(),
                  "highestPrize": "koreanLotteryInfo.highestPrize".tr(),
                  "frequency": "koreanLotteryInfo.frequency".tr(),
                  "ticketPrice": "koreanLotteryInfo.ticketPrice".tr(),
                  "drawDate": "koreanLotteryInfo.drawDate".tr(),
                  "purchasableArea": "koreanLotteryInfo.purchasableArea".tr(),
                  "prizeDetails": List<String>.from("koreanLotteryInfo.prizeDetails".tr().split('^')),
                  "winningMethods": List<String>.from("koreanLotteryInfo.winningMethods".tr().split('^')),
                  "probabilities": List<String>.from("koreanLotteryInfo.probabilities".tr().split('^'))
                },
              ),
              SizedBox(height: 16),
              LotteryMethodCard(
                title: "kLottoProcess".tr(),
                methods: List<String>.from("koreanLotteryMethods".tr().split('^')),
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
                    MaterialPageRoute(builder: (context) => NumberGenerator(lotto: "kLottoNumber")),
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
