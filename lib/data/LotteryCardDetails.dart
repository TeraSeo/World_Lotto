import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LotteryCardDetails {
  List<Map<String, dynamic>> usLotteries = [
    {
      "lottoName": "Powerball", 
      "dbTitle": "usPowerballNumber",
      "title": "americanLotteryInfo.title".tr(),
      "highestPrize": "americanLotteryInfo.highestPrize".tr(),
      "frequency": "americanLotteryInfo.frequency".tr(),
      "ticketPrice": "americanLotteryInfo.ticketPrice".tr(),
      "drawDate": "americanLotteryInfo.drawDate".tr(),
      "purchasableArea": "americanLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("americanLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("americanLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("americanLotteryInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 255, 137, 53),
        const Color(0xFFff0000)
      ], 
      "buttonColor": const Color(0xFFff0000),
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105),
      "dialogTopColor": Color.fromARGB(255, 243, 0, 0),
      "dialogButtonColor": const Color.fromARGB(255, 238, 121, 121),
      "normalNumberCount": 5,
      "bonusNumberCount": 1,
      "bonusNumberText": "Select Powerball Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    },
    {
      "lottoName": "MegaMillions",
      "dbTitle": "megaMillionNumber",
      "title": "megaMillionsInfo.title".tr(),
      "highestPrize": "megaMillionsInfo.highestPrize".tr(),
      "frequency": "megaMillionsInfo.frequency".tr(),
      "ticketPrice": "megaMillionsInfo.ticketPrice".tr(),
      "drawDate": "megaMillionsInfo.drawDate".tr(),
      "purchasableArea": "megaMillionsInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("megaMillionsInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("megaMillionsInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("megaMillionsInfo.probabilities".tr().split('^')),
      "color": [
        const Color(0xFF00ccff),
        const Color(0xFF0066ff)
      ],
      "buttonColor": const Color(0xFF0066ff),
      "backgroundColor": const Color.fromARGB(255, 83, 156, 240),
      "dialogTopColor": const Color(0xFF0066ff),
      "dialogButtonColor": const Color.fromARGB(255, 61, 143, 243),
      "normalNumberCount": 5,
      "bonusNumberCount": 1,
      "bonusNumberText": "Select Megaball Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    },
  ];

  List<Map<String, dynamic>> euLotteries = [
    {
      "lottoName": "Euromillon",
      "dbTitle": "euroMillionNumber",
      "title": "euroMillionsInfo.title".tr(),
      "highestPrize": "euroMillionsInfo.highestPrize".tr(),
      "frequency": "euroMillionsInfo.frequency".tr(),
      "ticketPrice": "euroMillionsInfo.ticketPrice".tr(),
      "drawDate": "euroMillionsInfo.drawDate".tr(),
      "purchasableArea": "euroMillionsInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("euroMillionsInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("euroMillionsInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("euroMillionsInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 201, 243, 160),
        const Color.fromARGB(255, 45, 50, 198),
      ],
      "buttonColor": Color.fromARGB(255, 45, 50, 198),
      "backgroundColor": const Color.fromARGB(255, 136, 154, 243),
      "dialogTopColor": const Color.fromARGB(255, 45, 50, 198),
      "dialogButtonColor": const Color.fromARGB(255, 57, 126, 210),
      "normalNumberCount": 5,
      "bonusNumberCount": 2,
      "bonusNumberText": "Select Lucky Stars Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    },
    {
      "lottoName": "EuroJackpot",
      "dbTitle": "euroJackpotNumber",
      "title": "euroJackpotInfo.title".tr(),
      "highestPrize": "euroJackpotInfo.highestPrize".tr(),
      "frequency": "euroJackpotInfo.frequency".tr(),
      "ticketPrice": "euroJackpotInfo.ticketPrice".tr(),
      "drawDate": "euroJackpotInfo.drawDate".tr(),
      "purchasableArea": "euroJackpotInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("euroJackpotInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("euroJackpotInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("euroJackpotInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 254, 251, 138), 
        const Color.fromARGB(255, 242, 189, 16), 
      ],
      "buttonColor": const Color.fromARGB(255, 242, 189, 16),
      "backgroundColor": const Color.fromARGB(255, 243, 210, 103),
      "dialogTopColor": const Color.fromARGB(255, 242, 189, 16),
      "dialogButtonColor": const Color.fromARGB(255, 240, 219, 149),
      "normalNumberCount": 5,
      "bonusNumberCount": 2,
      "bonusNumberText": "Select Lucky Stars Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    },
  ];

  List<Map<String, dynamic>> ukLotteries = [
    {
      "lottoName": "UkLotto",
      "dbTitle": "ukLotto",
      "title": "ukLottoInfo.title".tr(),
      "highestPrize": "ukLottoInfo.highestPrize".tr(),
      "frequency": "ukLottoInfo.frequency".tr(),
      "ticketPrice": "ukLottoInfo.ticketPrice".tr(),
      "drawDate": "ukLottoInfo.drawDate".tr(),
      "purchasableArea": "ukLottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("ukLottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("ukLottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("ukLottoInfo.probabilities".tr().split('^')),
      "color": [
        const Color.fromARGB(255, 255, 194, 218),
        const Color.fromARGB(255, 21, 0, 255), 
      ],
      "buttonColor": const Color.fromARGB(255, 21, 0, 255), 
      "backgroundColor": const Color.fromARGB(255, 84, 69, 245),
      "dialogTopColor": const Color.fromARGB(255, 21, 0, 255),
      "dialogButtonColor": const Color.fromARGB(255, 101, 89, 236),
      "normalNumberCount": 6,
      "bonusNumberCount": 0,
      "bonusNumberText": "",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    },
  ];

  List<Map<String, dynamic>> spainLotteries = [
    {
      "lottoName": "La Primitiva",
      "dbTitle": "laPrimitivaNumber",
      "title": "spanishLaPrimitivaInfo.title".tr(),
      "highestPrize": "spanishLaPrimitivaInfo.highestPrize".tr(),
      "frequency": "spanishLaPrimitivaInfo.frequency".tr(),
      "ticketPrice": "spanishLaPrimitivaInfo.ticketPrice".tr(),
      "drawDate": "spanishLaPrimitivaInfo.drawDate".tr(),
      "purchasableArea": "spanishLaPrimitivaInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("spanishLaPrimitivaInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("spanishLaPrimitivaInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("spanishLaPrimitivaInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 234, 113, 105), Color.fromARGB(255, 255, 165, 0)],
      "buttonColor": Color.fromARGB(255, 255, 165, 0),
      "backgroundColor": Color.fromARGB(255, 246, 181, 59),
      "dialogTopColor": Color.fromARGB(255, 255, 165, 0),
      "dialogButtonColor": Color.fromARGB(255, 241, 184, 78),
      "normalNumberCount": 6,
      "bonusNumberCount": 1,
      "bonusNumberText": "Select Reintegro Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    },
    {
      "lottoName": "El Gordo de La Primitiva",
      "dbTitle": "elGordoNumber",
      "title": "elGordoLotteryInfo.title".tr(),
      "highestPrize": "elGordoLotteryInfo.highestPrize".tr(),
      "frequency": "elGordoLotteryInfo.frequency".tr(),
      "ticketPrice": "elGordoLotteryInfo.ticketPrice".tr(),
      "drawDate": "elGordoLotteryInfo.drawDate".tr(),
      "purchasableArea": "elGordoLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("elGordoLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("elGordoLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("elGordoLotteryInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 176, 243, 31), Color.fromARGB(255, 0, 128, 0)],
      "buttonColor": Color.fromARGB(255, 0, 128, 0),
      "backgroundColor": Color.fromARGB(255, 29, 126, 29),
      "dialogTopColor": Color.fromARGB(255, 0, 128, 0),
      "dialogButtonColor": Color.fromARGB(255, 32, 120, 32),
      "normalNumberCount": 5,
      "bonusNumberCount": 1,
      "bonusNumberText": "Select Key Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    }
  ];

  List<Map<String, dynamic>> italyLotteries = [
    {
      "lottoName": "SuperEnalotto",
      "dbTitle": "superEnalottoNumber",
      "title": "superEnalottoInfo.title".tr(),
      "highestPrize": "superEnalottoInfo.highestPrize".tr(),
      "frequency": "superEnalottoInfo.frequency".tr(),
      "ticketPrice": "superEnalottoInfo.ticketPrice".tr(),
      "drawDate": "superEnalottoInfo.drawDate".tr(),
      "purchasableArea": "superEnalottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("superEnalottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("superEnalottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("superEnalottoInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 13, 175, 40), Color.fromARGB(255, 227, 220, 89)],
      "buttonColor": Color.fromARGB(255, 13, 175, 40),
      "backgroundColor": Color.fromARGB(255, 55, 183, 79),
      "dialogTopColor": Color.fromARGB(255, 13, 175, 40),
      "dialogButtonColor": Color.fromARGB(255, 80, 178, 80),
      "normalNumberCount": 6,
      "bonusNumberCount": 1,
      "bonusNumberText": "Select Jolly Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    }
  ];

  List<Map<String, dynamic>> ausLotteries = [
    {
      "lottoName": "AU Powerball",
      "dbTitle": "ausPowerBallNumber",
      "title": "australiaPowerballInfo.title".tr(),
      "highestPrize": "australiaPowerballInfo.highestPrize".tr(),
      "frequency": "australiaPowerballInfo.frequency".tr(),
      "ticketPrice": "australiaPowerballInfo.ticketPrice".tr(),
      "drawDate": "australiaPowerballInfo.drawDate".tr(),
      "purchasableArea": "australiaPowerballInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("australiaPowerballInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("australiaPowerballInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("australiaPowerballInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 76, 73, 227), Color.fromARGB(255, 215, 37, 37)],
      "buttonColor": const Color.fromARGB(255, 215, 37, 37),
      "backgroundColor": Color.fromARGB(255, 207, 58, 58),
      "dialogTopColor": Color.fromARGB(255, 215, 37, 37),
      "dialogButtonColor": Color.fromARGB(255, 202, 78, 78),
      "normalNumberCount": 7,
      "bonusNumberCount": 1,
      "bonusNumberText": "Select Powerball Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    }
  ];

  List<Map<String, dynamic>> krLotteries = [
    {
      "lottoName": "Lotto 6/45",
      "dbTitle": "kLottoNumber",
      "title": "koreanLotteryInfo.title".tr(),
      "highestPrize": "koreanLotteryInfo.highestPrize".tr(),
      "frequency": "koreanLotteryInfo.frequency".tr(),
      "ticketPrice": "koreanLotteryInfo.ticketPrice".tr(),
      "drawDate": "koreanLotteryInfo.drawDate".tr(),
      "purchasableArea": "koreanLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("koreanLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("koreanLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("koreanLotteryInfo.probabilities".tr().split('^')),
      "color": [Color.fromARGB(255, 174, 20, 246), Color.fromARGB(255, 255, 128, 0)],
      "buttonColor": Color.fromARGB(255, 255, 128, 0),
      "backgroundColor": Color.fromARGB(255, 248, 143, 38),
      "dialogTopColor": Color.fromARGB(255, 255, 128, 0),
      "dialogButtonColor": Color.fromARGB(255, 239, 141, 42),
      "normalNumberCount": 5,
      "bonusNumberCount": 1,
      "bonusNumberText": "Select Bonus Number",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    }
  ];

  List<Map<String, dynamic>> japanLotteries = [
    {
      "lottoName": "Lotto 6",
      "dbTitle": "jLottoNumber_1",
      "title": "japaneseLottery6Info.title".tr(),
      "highestPrize": "japaneseLottery6Info.highestPrize".tr(),
      "frequency": "japaneseLottery6Info.frequency".tr(),
      "ticketPrice": "japaneseLottery6Info.ticketPrice".tr(),
      "drawDate": "japaneseLottery6Info.drawDate".tr(),
      "purchasableArea": "japaneseLottery6Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("japaneseLottery6Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("japaneseLottery6Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("japaneseLottery6Info.probabilities".tr().split('^')),
      "color": [Colors.red, Colors.orange],
      "buttonColor": Colors.orange,
      "backgroundColor": const Color.fromARGB(255, 242, 162, 42),
      "dialogTopColor": Colors.orange,
      "dialogButtonColor": const Color.fromARGB(255, 251, 176, 64),
      "normalNumberCount": 6,
      "bonusNumberCount": 0,
      "bonusNumberText": "",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    },
    {
      "lottoName": "Lotto 7",
      "dbTitle": "jLottoNumber_2",
      "title": "japaneseLottery7Info.title".tr(),
      "highestPrize": "japaneseLottery7Info.highestPrize".tr(),
      "frequency": "japaneseLottery7Info.frequency".tr(),
      "ticketPrice": "japaneseLottery7Info.ticketPrice".tr(),
      "drawDate": "japaneseLottery7Info.drawDate".tr(),
      "purchasableArea": "japaneseLottery7Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("japaneseLottery7Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("japaneseLottery7Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("japaneseLottery7Info.probabilities".tr().split('^')),
      "color": [const Color.fromARGB(255, 220, 237, 33), Colors.red],
      "buttonColor": Colors.red,
      "backgroundColor": const Color.fromARGB(255, 241, 105, 105),
      "dialogTopColor": const Color.fromARGB(255, 236, 142, 142),
      "dialogButtonColor": const Color.fromARGB(255, 241, 105, 105),
      "normalNumberCount": 7,
      "bonusNumberCount": 0,
      "bonusNumberText": "",
      "reintegroNumberCount": 0,
      "reintegroNumberText": ""
    }
  ];
}