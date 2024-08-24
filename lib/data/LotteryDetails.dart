import 'package:easy_localization/easy_localization.dart';

class LotteryDetails {

  List<Map<String, dynamic>> lotteryDetails = [];

  List<Map<String, dynamic>> getLotteryDetails() {
    Map<String, dynamic> usPowerballDetail ={
      "title": "americanLotteryInfo.title".tr(),
      "highestPrize": "americanLotteryInfo.highestPrize".tr(),
      "frequency": "americanLotteryInfo.frequency".tr(),
      "ticketPrice": "americanLotteryInfo.ticketPrice".tr(),
      "drawDate": "americanLotteryInfo.drawDate".tr(),
      "purchasableArea": "americanLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("americanLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("americanLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("americanLotteryInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> megaMillionDetail = {
      "title": "megaMillionsInfo.title".tr(),
      "highestPrize": "megaMillionsInfo.highestPrize".tr(),
      "frequency": "megaMillionsInfo.frequency".tr(),
      "ticketPrice": "megaMillionsInfo.ticketPrice".tr(),
      "drawDate": "megaMillionsInfo.drawDate".tr(),
      "purchasableArea": "megaMillionsInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("megaMillionsInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("megaMillionsInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("megaMillionsInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> euroMillionDetail = {
      "title": "euroMillionsInfo.title".tr(),
      "highestPrize": "euroMillionsInfo.highestPrize".tr(),
      "frequency": "euroMillionsInfo.frequency".tr(),
      "ticketPrice": "euroMillionsInfo.ticketPrice".tr(),
      "drawDate": "euroMillionsInfo.drawDate".tr(),
      "purchasableArea": "euroMillionsInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("euroMillionsInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("euroMillionsInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("euroMillionsInfo.probabilities".tr().split('^'))
    };

     Map<String, dynamic> euroJackpotDetail = {
      "title": "euroJackpotInfo.title".tr(),
      "highestPrize": "euroJackpotInfo.highestPrize".tr(),
      "frequency": "euroJackpotInfo.frequency".tr(),
      "ticketPrice": "euroJackpotInfo.ticketPrice".tr(),
      "drawDate": "euroJackpotInfo.drawDate".tr(),
      "purchasableArea": "euroJackpotInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("euroJackpotInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("euroJackpotInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("euroJackpotInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> ukLottoDetail = {
      "title": "ukLottoInfo.title".tr(),
      "highestPrize": "ukLottoInfo.highestPrize".tr(),
      "frequency": "ukLottoInfo.frequency".tr(),
      "ticketPrice": "ukLottoInfo.ticketPrice".tr(),
      "drawDate": "ukLottoInfo.drawDate".tr(),
      "purchasableArea": "ukLottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("ukLottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("ukLottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("ukLottoInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> laPrimitivaDetail = {
      "title": "spanishLaPrimitivaInfo.title".tr(),
      "highestPrize": "spanishLaPrimitivaInfo.highestPrize".tr(),
      "frequency": "spanishLaPrimitivaInfo.frequency".tr(),
      "ticketPrice": "spanishLaPrimitivaInfo.ticketPrice".tr(),
      "drawDate": "spanishLaPrimitivaInfo.drawDate".tr(),
      "purchasableArea": "spanishLaPrimitivaInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("spanishLaPrimitivaInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("spanishLaPrimitivaInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("spanishLaPrimitivaInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> elGordoDetail = {
      "title": "elGordoLotteryInfo.title".tr(),
      "highestPrize": "elGordoLotteryInfo.highestPrize".tr(),
      "frequency": "elGordoLotteryInfo.frequency".tr(),
      "ticketPrice": "elGordoLotteryInfo.ticketPrice".tr(),
      "drawDate": "elGordoLotteryInfo.drawDate".tr(),
      "purchasableArea": "elGordoLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("elGordoLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("elGordoLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("elGordoLotteryInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> superEnalottoDetail = {
      "title": "superEnalottoInfo.title".tr(),
      "highestPrize": "superEnalottoInfo.highestPrize".tr(),
      "frequency": "superEnalottoInfo.frequency".tr(),
      "ticketPrice": "superEnalottoInfo.ticketPrice".tr(),
      "drawDate": "superEnalottoInfo.drawDate".tr(),
      "purchasableArea": "superEnalottoInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("superEnalottoInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("superEnalottoInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("superEnalottoInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> ausPowerballDetail = {
      "title": "australiaPowerballInfo.title".tr(),
      "highestPrize": "australiaPowerballInfo.highestPrize".tr(),
      "frequency": "australiaPowerballInfo.frequency".tr(),
      "ticketPrice": "australiaPowerballInfo.ticketPrice".tr(),
      "drawDate": "australiaPowerballInfo.drawDate".tr(),
      "purchasableArea": "australiaPowerballInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("australiaPowerballInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("australiaPowerballInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("australiaPowerballInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> kLottoDetail = {
      "title": "koreanLotteryInfo.title".tr(),
      "highestPrize": "koreanLotteryInfo.highestPrize".tr(),
      "frequency": "koreanLotteryInfo.frequency".tr(),
      "ticketPrice": "koreanLotteryInfo.ticketPrice".tr(),
      "drawDate": "koreanLotteryInfo.drawDate".tr(),
      "purchasableArea": "koreanLotteryInfo.purchasableArea".tr(),
      "prizeDetails": List<String>.from("koreanLotteryInfo.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("koreanLotteryInfo.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("koreanLotteryInfo.probabilities".tr().split('^'))
    };

    Map<String, dynamic> jLotto_1Detail = {
      "title": "japaneseLottery6Info.title".tr(),
      "highestPrize": "japaneseLottery6Info.highestPrize".tr(),
      "frequency": "japaneseLottery6Info.frequency".tr(),
      "ticketPrice": "japaneseLottery6Info.ticketPrice".tr(),
      "drawDate": "japaneseLottery6Info.drawDate".tr(),
      "purchasableArea": "japaneseLottery6Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("japaneseLottery6Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("japaneseLottery6Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("japaneseLottery6Info.probabilities".tr().split('^'))
    };

    Map<String, dynamic> jLotto_2Detail = {
      "title": "japaneseLottery7Info.title".tr(),
      "highestPrize": "japaneseLottery7Info.highestPrize".tr(),
      "frequency": "japaneseLottery7Info.frequency".tr(),
      "ticketPrice": "japaneseLottery7Info.ticketPrice".tr(),
      "drawDate": "japaneseLottery7Info.drawDate".tr(),
      "purchasableArea": "japaneseLottery7Info.purchasableArea".tr(),
      "prizeDetails": List<String>.from("japaneseLottery7Info.prizeDetails".tr().split('^')),
      "winningMethods": List<String>.from("japaneseLottery7Info.winningMethods".tr().split('^')),
      "probabilities": List<String>.from("japaneseLottery7Info.probabilities".tr().split('^'))
    };

    lotteryDetails.add(usPowerballDetail);
    lotteryDetails.add(megaMillionDetail);
    lotteryDetails.add(euroMillionDetail);
    lotteryDetails.add(euroJackpotDetail);
    lotteryDetails.add(ukLottoDetail);
    lotteryDetails.add(laPrimitivaDetail);
    lotteryDetails.add(elGordoDetail);
    lotteryDetails.add(superEnalottoDetail);
    lotteryDetails.add(ausPowerballDetail);
    lotteryDetails.add(kLottoDetail);
    lotteryDetails.add(jLotto_1Detail);
    lotteryDetails.add(jLotto_2Detail);

    return lotteryDetails;
  }
}