import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotteryService {
  // Private constructor
  LotteryService._privateConstructor();

  // The single instance of the class
  static final LotteryService _instance = LotteryService._privateConstructor();

  // Factory constructor to return the same instance
  factory LotteryService() {
    return _instance;
  }

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getLottoResults(String lottoName) async {
    Map<String, dynamic> results = {};
    try {
      CollectionReference lotto = _firestore.collection(lottoName);
      QuerySnapshot snapshot = await lotto.get();
      for (var doc in snapshot.docs) {
        results[lottoName] = doc.data() as Map<String, dynamic>;
      }
      return results;
    } catch (e) {
      print("Error fetching lotto results: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLotteryData(String lottoName) async {
    Map<String, dynamic> data = {};
    try {
      CollectionReference lotto = _firestore.collection(lottoName);
      QuerySnapshot snapshot = await lotto.get();
      for (var doc in snapshot.docs) {
        data = doc.data() as Map<String, dynamic>;
      }
      return data;
    } catch (e) {
      print("Error fetching lotto results: $e");
      rethrow;
    }
  }

  Future<List<List<dynamic>>> getMostWorstShownNumbers(String lottoName) async {
    List<List<dynamic>> results = [];
    try {
      CollectionReference lotto = _firestore.collection(lottoName);
      QuerySnapshot snapshot = await lotto.get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> res = {};
        res[lottoName] = doc.data() as Map<String, dynamic>;
        results.add(res[lottoName]["frequency"]["most"]);
        results.add(res[lottoName]["frequency"]["mostBonus"]);
        results.add(res[lottoName]["frequency"]["worst"]);
        results.add(res[lottoName]["frequency"]["worstBonus"]);
      }
      return results;
    } catch (e) {
      print("Error fetching lotto results: $e");
      return [];
    }
  }

  int checkUSPowerballPrize(List<String> userNumbers, String userPowerball, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    String winningPowerball = winningNumbers[5];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool powerballMatched = userPowerball == winningPowerball;

    if (matchedNumbers == 5 && powerballMatched) return 0; // 1st prize
    if (matchedNumbers == 5) return 1; // 2nd prize
    if (matchedNumbers == 4 && powerballMatched) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3 && powerballMatched) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (matchedNumbers == 2 && powerballMatched) return 6; // 7th prize
    if (matchedNumbers == 1 && powerballMatched) return 7; // 8th prize
    if (powerballMatched) return 8; // 9th prize
    
    return -1; // No prize
  }

  int checkMegaMillionsPrize(List<String> userNumbers, String userMegaBall, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    String winningMegaball = winningNumbers[5];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool megaBallMatched = userMegaBall == winningMegaball;

    if (matchedNumbers == 5 && megaBallMatched) return 0; // 1st prize
    if (matchedNumbers == 5) return 1; // 2nd prize
    if (matchedNumbers == 4 && megaBallMatched) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3 && megaBallMatched) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (matchedNumbers == 2 && megaBallMatched) return 6; // 7th prize
    if (matchedNumbers == 1 && megaBallMatched) return 7; // 8th prize
    if (megaBallMatched) return 8; // 9th prize

    return -1; // No prize
  }

  int checkEuroMillionsPrize(List<String> userNumbers, List<String> userLuckyStars, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    List<String> winningLuckyStars = winningNumbers.getRange(5, 7).toList();
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    int matchedLuckyStars = userLuckyStars.where((num) => winningLuckyStars.contains(num)).length;

    if (matchedNumbers == 5 && matchedLuckyStars == 2) return 0; // Jackpot
    if (matchedNumbers == 5 && matchedLuckyStars == 1) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4 && matchedLuckyStars == 2) return 3; // 4th prize
    if (matchedNumbers == 4 && matchedLuckyStars == 1) return 4; // 5th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 2) return 5; // 6th prize
    if (matchedNumbers == 4) return 6; // 7th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 2) return 7; // 8th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 1) return 8; // 9th prize
    if (matchedNumbers == 3) return 9; // 10th prize
    if (matchedNumbers == 1 && matchedLuckyStars == 2) return 10; // 11th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 1) return 11; // 12th prize
    if (matchedNumbers == 2) return 12; // 13th prize

    return -1; // No prize
  }

  int checkEuroJackpotPrize(List<String> userNumbers, List<String> userLuckyStars, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    List<String> winningLuckyStars = winningNumbers.getRange(5, 7).toList();
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    int matchedLuckyStars = userLuckyStars.where((num) => winningLuckyStars.contains(num)).length;

    if (matchedNumbers == 5 && matchedLuckyStars == 2) return 0; // Jackpot
    if (matchedNumbers == 5 && matchedLuckyStars == 1) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4 && matchedLuckyStars == 2) return 3; // 4th prize
    if (matchedNumbers == 4 && matchedLuckyStars == 1) return 4; // 5th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 2) return 5; // 6th prize
    if (matchedNumbers == 4) return 6; // 7th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 2) return 7; // 8th prize
    if (matchedNumbers == 3 && matchedLuckyStars == 1) return 8; // 9th prize
    if (matchedNumbers == 3) return 9; // 10th prize
    if (matchedNumbers == 1 && matchedLuckyStars == 2) return 10; // 11th prize
    if (matchedNumbers == 2 && matchedLuckyStars == 1) return 11; // 12th prize

    return -1; // No prize
  }

  int checkUKLottoPrize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningBonus = winningNumbers[6];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool bonusMatched = userNumbers.contains(winningBonus);

    if (matchedNumbers == 6) return 0; // 1st prize
    if (matchedNumbers == 5 && bonusMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize
    if (matchedNumbers == 2) return 5; // 5th prize

    return -1; // No prize
  }

  int checkLaPrimitivaPrize(List<String> userNumbers, String userReintegro, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningComplementary = winningNumbers[6];
    String winningReintegro = winningNumbers[7];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool reintegroMatched = userReintegro == winningReintegro;

    if (matchedNumbers == 6 && reintegroMatched) return 0; // Jackpot
    if (matchedNumbers == 6) return 1; // 2nd prize
    if (matchedNumbers == 5 && userNumbers.contains(winningComplementary)) return 2; // 3rd prize
    if (matchedNumbers == 5) return 3; // 4th prize
    if (matchedNumbers == 4) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (reintegroMatched) return 6; // Reintegro prize (ticket refund)

    return -1; // No prize
  }

  int checkElGordoPrize(List<String> userNumbers, String userClave, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 5).toList();
    String winningClave = winningNumbers[5];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool claveMatched = userClave == winningClave;

    if (matchedNumbers == 5 && claveMatched) return 0; // Jackpot
    if (matchedNumbers == 5) return 1; // 2nd prize
    if (matchedNumbers == 4 && claveMatched) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3 && claveMatched) return 4; // 5th prize
    if (matchedNumbers == 3) return 5; // 6th prize
    if (matchedNumbers == 2 && claveMatched) return 6; // 7th prize
    if (matchedNumbers == 2) return 7; // 8th prize
    if (claveMatched) return 8; // 9th prize

    return -1; // No prize
  }

  int checksuperEnalottoNumberPrize(List<String> userNumbers, String userJolly, List<String> winningNumbers) {
    List<String> mainNumbers = winningNumbers.getRange(0, 6).toList();  // First 6 are main numbers
    String winningJolly = winningNumbers[6];  // 7th number is the Jolly number
    int matchedNumbers = userNumbers.where((num) => mainNumbers.contains(num)).length;
    bool jollyMatched = userJolly == winningJolly;

    if (matchedNumbers == 6) return 0; // Jackpot
    if (matchedNumbers == 5 && jollyMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize
    if (matchedNumbers == 2) return 5; // 6th prize

    return -1; // No prize
  }

  int checkAustraliaPowerballPrize(List<String> userNumbers, String userPowerball, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 7).toList();
    String winningPowerball = winningNumbers[7];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool powerballMatched = userPowerball == winningPowerball;

    if (matchedNumbers == 7 && powerballMatched) return 0; // Jackpot
    if (matchedNumbers == 7) return 1; // 2nd prize
    if (matchedNumbers == 6 && powerballMatched) return 2; // 3rd prize
    if (matchedNumbers == 6) return 3; // 4th prize
    if (matchedNumbers == 5 && powerballMatched) return 4; // 5th prize
    if (matchedNumbers == 5) return 5; // 6th prize
    if (matchedNumbers == 4 && powerballMatched) return 6; // 7th prize
    if (matchedNumbers == 3 && powerballMatched) return 7; // 8th prize

    return -1; // No prize
  }

  int checkKoreaLottoPrize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningBonus = winningNumbers[6];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool bonusMatched = userNumbers.contains(winningBonus);

    if (matchedNumbers == 6) return 0; // 1st prize
    if (matchedNumbers == 5 && bonusMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize

    return -1; // No prize
  }

  int checkJapanLotto6Prize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 6).toList();
    String winningBonus = winningNumbers[6];
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    bool bonusMatched = userNumbers.contains(winningBonus);

    if (matchedNumbers == 6) return 0; // 1st prize
    if (matchedNumbers == 5 && bonusMatched) return 1; // 2nd prize
    if (matchedNumbers == 5) return 2; // 3rd prize
    if (matchedNumbers == 4) return 3; // 4th prize
    if (matchedNumbers == 3) return 4; // 5th prize

    return -1; // No prize
  }

  int checkJapanLotto7Prize(List<String> userNumbers, List<String> winningNumbers) {
    List<String> numbers = winningNumbers.getRange(0, 7).toList();
    List<String> winningBonus = winningNumbers.getRange(7, 9).toList();
    int matchedNumbers = userNumbers.where((num) => numbers.contains(num)).length;
    int matchedBonusNumbers = userNumbers.where((num) => winningBonus.contains(num)).length;

    if (matchedNumbers == 7) return 0; // 1st prize
    if (matchedNumbers == 6 && matchedBonusNumbers <= 2) return 1; // 2nd prize
    if (matchedNumbers == 6) return 2; // 3rd prize
    if (matchedNumbers == 5) return 3; // 4th prize
    if (matchedNumbers == 4) return 4; // 5th prize
    if (matchedNumbers == 3 && matchedBonusNumbers <= 2) return 5; // 6th prize

    return -1; // No prize
  }

  int checkPrize(String lottoName, List<String> userNumbers, List<String> bonusNumbers, List<Map<String, dynamic>> results) {
    if (lottoName == "usPowerballNumber") {
      return checkUSPowerballPrize(userNumbers, bonusNumbers[0], results[0][lottoName]["number"].split(","));
    }
    else if (lottoName == "megaMillionNumber") {
      return checkMegaMillionsPrize(userNumbers, bonusNumbers[0], results[1][lottoName]['number'].split(","));
    }
    else if (lottoName == "euroMillionNumber") {
      return checkEuroMillionsPrize(userNumbers, bonusNumbers, results[2][lottoName]['number'].split(","));
    }
    else if (lottoName == "euroJackpotNumber") {
      return checkEuroJackpotPrize(userNumbers, bonusNumbers, results[3][lottoName]['number'].split(","));
    }
    else if (lottoName == "ukLotto") {
      return checkUKLottoPrize(userNumbers, results[4][lottoName]['number'].split(","));
    }
    else if (lottoName == "laPrimitivaNumber") {
      return checkLaPrimitivaPrize(userNumbers, bonusNumbers[0], results[5][lottoName]['number'].split(","));
    }
    else if (lottoName == "elGordoNumber") {
      return checkElGordoPrize(userNumbers, bonusNumbers[0], results[6][lottoName]['number'].split(","));
    }
    else if (lottoName == "superEnalottoNumber") {
      return checksuperEnalottoNumberPrize(userNumbers, bonusNumbers[0], results[7][lottoName]['number'].split(","));
    }
    else if (lottoName == "ausPowerBallNumber") {
      return checkAustraliaPowerballPrize(userNumbers, bonusNumbers[0], results[8][lottoName]['number'].split(","));
    }
    else if (lottoName == "kLottoNumber") {
      return checkKoreaLottoPrize(userNumbers, results[9][lottoName]['number'].split(","));
    }
    else if (lottoName == "jLottoNumber_1") {
      return checkJapanLotto6Prize(userNumbers, results[10][lottoName]['number'].split(","));
    }
    else if (lottoName == "jLottoNumber_2") {
      return checkJapanLotto7Prize(userNumbers, results[11][lottoName]['number'].split(","));
    }
    return -1;
  }

  List<List<dynamic>> getSeparatedNumberAndBonus(String numberTxt, String lottoName) {
    List<List<dynamic>> separatedNumbers = [[],[],[]];

    List<dynamic> numbers = numberTxt.split(",");
    switch (lottoName) {
      case "usPowerballNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "megaMillionNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "euroMillionNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = numbers.getRange(5, 7).toList();
        break;
      case "euroJackpotNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = numbers.getRange(5, 7).toList();
        break;
      case "ukLotto":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "laPrimitivaNumber":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        separatedNumbers[2] = [numbers[7]];
        break;
      case "elGordoNumber":
        separatedNumbers[0] = numbers.getRange(0, 5).toList();
        separatedNumbers[1] = [numbers[5]];
        break;
      case "superEnalottoNumber":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "ausPowerBallNumber":
        separatedNumbers[0] = numbers.getRange(0, 7).toList();
        separatedNumbers[1] = [numbers[7]];
        break;
      case "kLottoNumber":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "jLottoNumber_1":
        separatedNumbers[0] = numbers.getRange(0, 6).toList();
        separatedNumbers[1] = [numbers[6]];
        break;
      case "jLottoNumber_2":
        separatedNumbers[0] = numbers.getRange(0, 7).toList();
        separatedNumbers[1] = numbers.getRange(7, 9).toList();
        break;
      default:
        break;
    }

    return separatedNumbers;
  }

  Future<void> saveNumbers(String name, List<Map<String, List<dynamic>>> numbers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the list of maps to a List of Map<String, dynamic> for json encoding
    List<Map<String, dynamic>> numbersToSave = numbers.map((map) {
      return map.map((key, value) => MapEntry(key, value));
    }).toList();
    String numbersJson = jsonEncode(numbersToSave);
    await prefs.setString(name, numbersJson);
  }

  Future<List<Map<String, List<dynamic>>>?> loadNumbers(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? numbersJson = prefs.getString(name);
    
    if (numbersJson != null) {
      // Decode the JSON back to a List of Maps
      List<dynamic> decodedJson = jsonDecode(numbersJson);
      List<Map<String, List<dynamic>>> numbers = decodedJson.map((item) {
        return Map<String, List<dynamic>>.from(item);
      }).toList();
      
      return numbers;
    }
    
    return null;
  }
}
