import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/Home.dart';
import 'package:lottery_kr/page/generator/AusPowerballGenerator.dart';
import 'package:lottery_kr/page/generator/ElGordoDeGenerator.dart';
import 'package:lottery_kr/page/generator/EuroJackpotGenerator.dart';
import 'package:lottery_kr/page/generator/EuroMillonGenerator.dart';
import 'package:lottery_kr/page/generator/JapanLotto1Generator.dart';
import 'package:lottery_kr/page/generator/JapanLotto2Generator.dart';
import 'package:lottery_kr/page/generator/KoreanNumberGenerator.dart';
import 'package:lottery_kr/page/generator/LaPrimitivaNumberGenerator.dart';
import 'package:lottery_kr/page/generator/MegaMillionGenerator.dart';
import 'package:lottery_kr/page/generator/SuperEnalottoGenerator.dart';
import 'package:lottery_kr/page/generator/UKLottoGenerator.dart';
import 'package:lottery_kr/page/generator/USPowerballGenerator.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textfield_tags/textfield_tags.dart';

class NumberGenerateService {

  NumberGenerateService._privateConstructor();

  // The single instance of the class
  static final NumberGenerateService _instance = NumberGenerateService._privateConstructor();

  // Factory constructor to return the same instance
  factory NumberGenerateService() {
    return _instance;
  }

  int getNumberOfBalls(String dbTitle) {
    switch(dbTitle) {
      case "usPowerballNumber":
        return 69;
      case "megaMillionNumber":
        return 70;
      case "euroMillionNumber":
        return 50;
      case "euroJackpotNumber":
        return 50;
      case "ukLotto":
        return 59;
      case "laPrimitivaNumber":
        return 49;
      case "elGordoNumber":
        return 54;
      case "superEnalottoNumber":
        return 90;
      case "ausPowerBallNumber":
        return 35;
      case "kLottoNumber":
        return 45;
      case "jLottoNumber_1":
        return 43;
      case "jLottoNumber_2":
        return 37;
      default: 
        return 0;
    }
  }

  int getBonusNumberOfBalls(String dbTitle) {
    switch(dbTitle) {
      case "usPowerballNumber":
        return 26;
      case "megaMillionNumber":
        return 25;
      case "euroMillionNumber":
        return 12;
      case "euroJackpotNumber":
        return 12;
      case "ukLotto":
        return 0;
      case "laPrimitivaNumber":
        return 9;
      case "elGordoNumber":
        return 9;
      case "superEnalottoNumber":
        return 90;
      case "ausPowerBallNumber":
        return 20;
      case "kLottoNumber":
        return 45;
      case "jLottoNumber_1":
        return 0;
      case "jLottoNumber_2":
        return 37;
      default: 
        return 0;
    }
  }

  void popGeneratorPage(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  void navigateToNumberGeneratorPage(Map<String, dynamic> lotteryDetails, Map<String, dynamic> lotteryData, BuildContext context) {
    switch (lotteryDetails["dbTitle"]) {
      case "usPowerballNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => USPowerballGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "megaMillionNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MegaMillionGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "euroMillionNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EuroMillonGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "euroJackpotNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EuroJackpotGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "ukLotto":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UKLottoGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "laPrimitivaNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LaPrimitivaNumberGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "elGordoNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ElGordoDeGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "superEnalottoNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuperEnalottoGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "ausPowerBallNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AusPowerballGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "kLottoNumber":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KoreanNumberGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "jLottoNumber_1":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JapanLotto1Generator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      case "jLottoNumber_2":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JapanLotto2Generator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
        );
        break;
      default: 
        break;
    }
  }

  void navigateToNumberGeneratorPageNResetToHome(Map<String, dynamic> lotteryDetails, Map<String, dynamic> lotteryData, BuildContext context) {
    switch (lotteryDetails["dbTitle"]) {
      case "usPowerballNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => USPowerballGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home')
        );
        break;
      case "megaMillionNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MegaMillionGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home')
        );
        break;
      case "euroMillionNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => EuroMillonGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home')
        );
        break;
      case "euroJackpotNumber":
         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => EuroJackpotGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "ukLotto":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UKLottoGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "laPrimitivaNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LaPrimitivaNumberGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "elGordoNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ElGordoDeGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "superEnalottoNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SuperEnalottoGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "ausPowerBallNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AusPowerballGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "kLottoNumber":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => KoreanNumberGenerator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "jLottoNumber_1":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => JapanLotto1Generator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      case "jLottoNumber_2":
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => JapanLotto2Generator(
              lotteryDetails: lotteryDetails, 
              lotteryData: lotteryData,
            ),
          ),
          ModalRoute.withName('/Home'),
        );
        break;
      default: 
        break;
    }
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

  Future<int> loadMaxCapacity() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? capacity = prefs.getInt('capacity');
      if (capacity == null) {
        return 10;
      }
      return capacity;
    } catch (e) {
      return 10;
    }
  }

  Future<Map<String, List<int>>?> generateNumberByLottoName(String dbTitle, int generatedNumbersCnt, BuildContext context) async {
    int capacity = await loadMaxCapacity();
    if (generatedNumbersCnt < capacity) {
      switch(dbTitle) {
        case "Powerball":
          return generateUsPowerballNumber();
        case "MegaMillions":
          return generateMegaMillonNumber();
        case "Euromillon":
          return generateEuroMillonNumber();
        case "EuroJackpot":
          return generateEuroJackpotNumber();
        case "UkLotto":
          return generateUKLottoNumber();
        case "La Primitiva":
          return generateLaPrimitivaNumber();
        case "El Gordo de La Primitiva":
          return generateElGordoNumber();
        case "SuperEnalotto":
          return generateSuperEnalottoNumber();
        case "AU Powerball":
          return generateAusPowerballNumber();
        case "Lotto 6/45":
          return generateKoreanNumber();
        case "Lotto 6":
          return generateJapan1Number();
        case "Lotto 7":
          return generateJapan2Number();
        default:
          return null;
      }
    } else {
      HelperFunctions helperFunctions = HelperFunctions();
      if (capacity < 30) helperFunctions.askExpandCapacityDialog(context);
      return null;
    }
  }

  Map<String, List<int>>? generateUsPowerballNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    List<int> _bonusNumber = [];
    Random random = Random();
    while (_lottoNumbers.length < 5) {
      int nextNumber = random.nextInt(69) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    int powerball;
    powerball = random.nextInt(26) + 1;
    _bonusNumber.add(powerball);
    numbersMap = {'numbers': _lottoNumbers, 'bonus': _bonusNumber, 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateMegaMillonNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    List<int> _bonusNumber = [];
    Random random = Random();
    while (_lottoNumbers.length < 5) {
      int nextNumber = random.nextInt(70) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    int megaBall;
    megaBall = random.nextInt(25) + 1;
    _bonusNumber.add(megaBall);
    numbersMap = {'numbers': _lottoNumbers, 'bonus': _bonusNumber, 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateEuroMillonNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    List<int> _bonusNumber = [];
    Random random = Random();
    while (_lottoNumbers.length < 5) {
      int nextNumber = random.nextInt(50) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    List<int> luckyStars = [];
    while (luckyStars.length < 2) {
      int nextStar;
      nextStar = random.nextInt(12) + 1;
      if (!luckyStars.contains(nextStar)) luckyStars.add(nextStar);
    }
    _bonusNumber.addAll(luckyStars);
    numbersMap = {'numbers': _lottoNumbers, 'bonus': _bonusNumber, 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateEuroJackpotNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    List<int> _bonusNumber = [];
    Random random = Random();
    while (_lottoNumbers.length < 5) {
      int nextNumber = random.nextInt(50) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    List<int> luckyStars = [];
    while (luckyStars.length < 2) {
      int nextStar;
      nextStar = random.nextInt(12) + 1;
      if (!luckyStars.contains(nextStar)) luckyStars.add(nextStar);
    }
    _bonusNumber.addAll(luckyStars);
    numbersMap = {'numbers': _lottoNumbers, 'bonus': _bonusNumber, 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateUKLottoNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 6) {
      int nextNumber = random.nextInt(59) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [], 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateLaPrimitivaNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 6) {
      int nextNumber = random.nextInt(49) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    int keyNumber = random.nextInt(9) + 1;
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [keyNumber], 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateElGordoNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 5) {
      int nextNumber = random.nextInt(54) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    int keyNumber = random.nextInt(9) + 1;
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [keyNumber], 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateSuperEnalottoNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 6) {
      int nextNumber = random.nextInt(90) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    int jollyNumber = random.nextInt(90) + 1;
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [jollyNumber], 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateAusPowerballNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 7) {
      int nextNumber = random.nextInt(35) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    int powerball = random.nextInt(20) + 1;
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [powerball], 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateKoreanNumber() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 5) {
      int nextNumber = random.nextInt(45) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    int bonus = random.nextInt(45) + 1;
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [bonus], 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateJapan1Number() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 6) {
      int nextNumber = random.nextInt(43) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [], 'reintegro': []};
    return numbersMap;
  }

  Map<String, List<int>>? generateJapan2Number() {
    Map<String, List<int>> numbersMap;
    List<int> _lottoNumbers = [];
    Random random = Random();
    while (_lottoNumbers.length < 7) {
      int nextNumber = random.nextInt(37) + 1;
      if (!_lottoNumbers.contains(nextNumber)) {
        _lottoNumbers.add(nextNumber);
      }
    }
    _lottoNumbers.sort();
    numbersMap = {'numbers': _lottoNumbers, 'bonus': [], 'reintegro': []};
    return numbersMap;
  }
}