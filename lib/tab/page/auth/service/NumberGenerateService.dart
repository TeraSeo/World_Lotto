import 'package:easy_localization/easy_localization.dart';
import 'package:textfield_tags/textfield_tags.dart';

class NumberGenerateService {

  NumberGenerateService._privateConstructor();

  // The single instance of the class
  static final NumberGenerateService _instance = NumberGenerateService._privateConstructor();

  // Factory constructor to return the same instance
  factory NumberGenerateService() {
    return _instance;
  }

  String checkNumberCondition(String lottoName, StringTagController _manualTagController, String tag) {
    String res = "";
    switch(lottoName) {
      case "usPowerballNumber":
        if (_manualTagController.getTags!.length >= 6) {
          res = "usPowerballNumberCntLimit".tr();
        }
        else if ((int.parse(tag) > 69 || int.parse(tag) <= 0) && _manualTagController.getTags!.length != 5) {
          res = "usPowerballNumberLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag) && _manualTagController.getTags!.length != 5) {
          return "numberDuplicated".tr();
        }
        else if (_manualTagController.getTags!.length == 5 && (int.parse(tag) > 26 || int.parse(tag) <= 0)) {
          res = "usPowerballBonusNumberLimit".tr();
        }
        break;
      case "megaMillionNumber":
        if (_manualTagController.getTags!.length >= 6) {
          res = "megaMillionNumberCntLimit".tr();
        }
        else if ((int.parse(tag) > 70 || int.parse(tag) <= 0) && _manualTagController.getTags!.length != 5) {
          res = "megaMillionNumberLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag) && _manualTagController.getTags!.length != 5) {
          return "numberDuplicated".tr();
        }
        else if (_manualTagController.getTags!.length == 5 && (int.parse(tag) > 25 || int.parse(tag) <= 0)) {
          res = "megaMillionBonusNumberLimit".tr();
        }
        break;
      case "ausPowerBallNumber":
        if (_manualTagController.getTags!.length >= 8) {
          res = "ausPowerBallNumberCntLimit".tr();
        }
        else if ((int.parse(tag) > 35  || int.parse(tag) <= 0) && _manualTagController.getTags!.length != 7) {
          res = "ausPowerBallNumberLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag) && _manualTagController.getTags!.length != 7) {
          return "numberDuplicated".tr();
        }
        else if (_manualTagController.getTags!.length == 7 && (int.parse(tag) > 20  || int.parse(tag) <= 0)) {
          res = "ausPowerBallBonusNumberLimit".tr();
        }
        break;
      case "euroMillionNumber":
        if (_manualTagController.getTags!.length >= 7) {
          res = "euroMillionNumberCntLimit".tr();
        }
        else if ((int.parse(tag) > 50 || int.parse(tag) <= 0) && _manualTagController.getTags!.length < 5) {
          res = "euroMillionNumberLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag) && _manualTagController.getTags!.length < 5) {
          return "numberDuplicated".tr();
        }
        else if (_manualTagController.getTags!.length >= 5 && (int.parse(tag) > 12 || int.parse(tag) <= 0)) {
          res = "euroMillionBonusNumberLimit".tr();
        }
        break;
      case "euroJackpotNumber":
        if (_manualTagController.getTags!.length >= 7) {
          res = "euroJackpotNumberCntLimit".tr();
        }
        else if ((int.parse(tag) > 50 || int.parse(tag) <= 0) && _manualTagController.getTags!.length < 5) {
          res = "euroJackpotNumberLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag) && _manualTagController.getTags!.length < 5) {
          return "numberDuplicated".tr();
        }
        else if (_manualTagController.getTags!.length >= 5 && (int.parse(tag) > 12 || int.parse(tag) <= 0)) {
          res = "euroJackpotBonusNumberLimit".tr();
        }
        break;
      case "ukLotto":
        if (_manualTagController.getTags!.length >= 6) {
          res = "ukLottoNumberCntLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag)) {
          return "numberDuplicated".tr();
        }
        else if (int.parse(tag) > 59 || int.parse(tag) <= 0) {
          res = "ukLottoNumberLimit".tr();
        }
        break;
      case "superEnalottoNumber":
        if (_manualTagController.getTags!.length >= 7) {
          res = "superEnalottoNumberCntLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag)) {
          return "numberDuplicated".tr();
        }
        else if (int.parse(tag) > 90 || int.parse(tag) <= 0) {
          res = "superEnalottoNumberLimit".tr();
        }
        break;
      case "jLottoNumber_1":
        if (_manualTagController.getTags!.length >= 6) {
          res = "jLotto_1NumberCntLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag)) {
          return "numberDuplicated".tr();
        }
        else if (int.parse(tag) > 43 || int.parse(tag) <= 0) {
          res = "jLotto_1NumberLimit".tr();
        }
        break;
      case "jLottoNumber_2":
        if (_manualTagController.getTags!.length >= 7) {
          res = "jLotto_2NumberCntLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag)) {
          return "numberDuplicated".tr();
        }
        else if (int.parse(tag) > 37 || int.parse(tag) <= 0) {
          res = "jLotto_2NumberLimit".tr();
        }
        break;
      case "kLottoNumber":
        if (_manualTagController.getTags!.length >= 6) {
          res = "kLottoNumberCntLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag)) {
          return "numberDuplicated".tr();
        }
        else if (int.parse(tag) > 45 || int.parse(tag) <= 0) {
          res = "kLottoNumberLimit".tr();
        }
        break;
      case "laPrimitivaNumber":
        if (_manualTagController.getTags!.length >= 7) {
          res = "laPrimitivaNumberCntLimit".tr();
        }
        else if ((int.parse(tag) > 49 || int.parse(tag) <= 0) && _manualTagController.getTags!.length != 6) {
          res = "laPrimitivaNumberLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag) && _manualTagController.getTags!.length != 6) {
          return "numberDuplicated".tr();
        }
        else if (_manualTagController.getTags!.length == 6 && (int.parse(tag) > 9 || int.parse(tag) < 0)) {
          res = "laPrimitivaBonusNumberLimit".tr();
        }
        break;
      case "elGordoNumber":
        if (_manualTagController.getTags!.length >= 6) {
          res = "elGordoNumberNumberCntLimit".tr();
        }
        else if ((int.parse(tag) > 54 || int.parse(tag) <= 0) && _manualTagController.getTags!.length != 5) {
          res = "elGordoNumberLimit".tr();
        }
        else if (_manualTagController.getTags!.contains(tag) && _manualTagController.getTags!.length != 5) {
          return "numberDuplicated".tr();
        }
        else if (_manualTagController.getTags!.length == 5 && (int.parse(tag) > 9 || int.parse(tag) < 0)) {
          res = "elGordoBonusNumberLimit".tr();
        }
        break;
      default:
        break;
    }
    return res;
  }

}