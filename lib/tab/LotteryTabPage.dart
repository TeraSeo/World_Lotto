import 'package:flutter/material.dart';
import 'package:lottery_kr/page/country/AmericanLotto.dart';
import 'package:lottery_kr/page/country/AustraliaLottery.dart';
import 'package:lottery_kr/page/country/EuroLottery.dart';
import 'package:lottery_kr/page/country/ItalianLotto.dart';
import 'package:lottery_kr/page/country/JapaneseLottery.dart';
import 'package:lottery_kr/page/country/KoreanLottery.dart';
import 'package:lottery_kr/page/country/SpanishLottery.dart';
import 'package:lottery_kr/page/country/UKLotto.dart';

class LotteryTabPage extends StatefulWidget {

  final String content;
  const LotteryTabPage({super.key, required this.content});

  @override
  State<LotteryTabPage> createState() => _LotteryTabPageState();
}

class _LotteryTabPageState extends State<LotteryTabPage> {
  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget _getContent() {
    switch (widget.content) {
      case 'Korea':
        return KoreanLottery();
      case 'USA':
        return AmericanLottery();
      case 'EU':
        return EuroLottery();
      case 'Spain':
        return SpanishLottery();
      case 'UK':
        return UkLottery();
      case 'Italy':
        return ItalianLottery();
      case 'Australia':
        return AustraliaLottery();
      case 'Japan':
        return JapaneseLottery();
      default:
        return Container();
    }
  }
}
