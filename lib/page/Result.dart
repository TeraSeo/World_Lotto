import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:lottery_kr/ads/BannerAdPage1.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List<String> lottos = [
    "usPowerballNumber", "megaMillionNumber", "euroMillionNumber", "euroJackpotNumber",
    "ukLotto", "laPrimitivaNumber", "elGordoNumber", "superEnalottoNumber", "ausPowerBallNumber",
    "kLottoNumber", "jLottoNumber_1", "jLottoNumber_2"
  ];
  List<Map<String, dynamic>> _allGeneratedNumbers = [];
  List<Map<String, dynamic>> results = [];
  List<int> rankList = [];
  List<Map<String, dynamic>> numberResults = [];
  List<String> timeResults = [];
  List<List<dynamic>> prizeList = [];

  DateFormat format = DateFormat('dd/MM/yyyy');

  LotteryService lotteryService = LotteryService();

  bool isResultLoading = true;
  bool isDataLoading = true;
  bool isPrizeLoading = true;
  
  int cnt = -1;

  // late final InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) async {
      // showInterstitialAd();
      _allGeneratedNumbers = await _loadData();
      fetchLottoResults(_allGeneratedNumbers).then((value) {
        if (this.mounted) {
          setState(() {
            results = value;
            isResultLoading = false;
          });
        }
        getPrizeResults(value).then((value) {
          if (this.mounted) {
            setState(() {
              rankList = value;
              isPrizeLoading = false;
            });
          }
        });
      });
    });
  }

  Future<List<Map<String, dynamic>>> _loadData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> loadedNumbers = [];

      for (String lotto in lottos) {
        List<String> stringList = prefs.getStringList(lotto) ?? [];
        List<Map<String, List<int>>> numbersList = stringList.map((str) {
          List<String> parts = str.split(";");
          List<int> numbers = parts[0].split(",").map((num) => int.parse(num)).toList();
          List<int> bonus = parts.length > 1 ? parts[1].split(",").map((num) => int.parse(num)).toList() : [];
          return {'numbers': numbers, 'bonus': bonus};
        }).toList();
        loadedNumbers.add({
          'title': lotto,
          'results': numbersList,
        });
      }

      setState(() {
        isDataLoading = false;
      });

      return loadedNumbers;
    } catch (e) {
      debugPrint('Failed to load data: $e');
      setState(() {
        isDataLoading = false;
      });
      return [];
    }
  }

  Future<List<int>> getPrizeResults(List<Map<String, dynamic>> results) async {
    List<int> rankList = [];
    for (int i = 0; i < _allGeneratedNumbers.length; i++) {
      Map<String, dynamic> map = _allGeneratedNumbers[i];
      if (map['results'].length != 0) {
        for (int l = 0; l < map['results'].length; l++) {
          String lottoName = map['title'];
          List<dynamic> p = [];
          Map<String, dynamic> resMap = new Map<String, dynamic>();
          String formattedDate = "";
          switch (lottoName) {
            case "usPowerballNumber":
              p = results[0]['usPowerballNumber']['prize'];
              List<dynamic> resNum = results[0]['usPowerballNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 5), 'bonus': resNum[5]};
              Timestamp time = results[0]['usPowerballNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "megaMillionNumber":
              p = results[1]['megaMillionNumber']['prize'];
              List<dynamic> resNum = results[1]['megaMillionNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 5), 'bonus': resNum[5]};
              Timestamp time = results[1]['megaMillionNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "euroMillionNumber":
              p = results[2]['euroMillionNumber']['prize'];
              List<dynamic> resNum = results[2]['euroMillionNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 5), 'bonus': resNum.getRange(5, 7)};
              Timestamp time = results[2]['euroMillionNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "euroJackpotNumber":
              p = results[3]['euroJackpotNumber']['prize'];
              List<dynamic> resNum = results[3]['euroJackpotNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 5), 'bonus': resNum.getRange(5, 7)};
              Timestamp time = results[3]['euroJackpotNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "ukLotto":
              p = results[4]['ukLotto']['prize'];
              List<dynamic> resNum = results[4]['ukLotto']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 6), 'bonus': resNum[6]};
              Timestamp time = results[4]['ukLotto']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "laPrimitivaNumber":
              p = results[5]['laPrimitivaNumber']['prize'];
              List<dynamic> resNum = results[5]['laPrimitivaNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 6), 'bonus': resNum.getRange(6, 8)};
              Timestamp time = results[5]['laPrimitivaNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "elGordoNumber":
              p = results[6]['elGordoNumber']['prize'];
              List<dynamic> resNum = results[6]['elGordoNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 5), 'bonus': resNum[5]};
              Timestamp time = results[6]['elGordoNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "superEnalottoNumber":
              p = results[7]['superEnalottoNumber']['prize'];
              List<dynamic> resNum = results[7]['superEnalottoNumber']['number'].split(",");
              resMap = {
                'number': resNum.getRange(0, 6),  // Extracting the 6 main numbers
                'bonus': resNum[6]  // Assuming the 7th number is the Jolly number
              };
              Timestamp time = results[7]['superEnalottoNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "ausPowerBallNumber":
              p = results[8]['ausPowerBallNumber']['prize'];
              List<dynamic> resNum = results[8]['ausPowerBallNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 7), 'bonus': resNum[7]};
              Timestamp time = results[8]['ausPowerBallNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "kLottoNumber":
              p = results[9]['kLottoNumber']['prize'];
              List<dynamic> resNum = results[9]['kLottoNumber']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 6), 'bonus': resNum[6]};
              Timestamp time = results[9]['kLottoNumber']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "jLottoNumber_1":
              p = results[10]['jLottoNumber_1']['prize'];
              List<dynamic> resNum = results[10]['jLottoNumber_1']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 6), 'bonus': resNum[6]};
              Timestamp time = results[10]['jLottoNumber_1']['time'];
              formattedDate = format.format(time.toDate());
              break;
            case "jLottoNumber_2":
              p = results[11]['jLottoNumber_2']['prize'];
              List<dynamic> resNum = results[11]['jLottoNumber_2']['number'].split(",");
              resMap = {'number': resNum.getRange(0, 7), 'bonus': resNum.getRange(7, 9)};
              Timestamp time = results[11]['jLottoNumber_2']['time'];
              formattedDate = format.format(time.toDate());
              break;
            default: 
              break;
          }
          timeResults.add(formattedDate);
          numberResults.add(resMap);
          prizeList.add(p);
          List<int> numbers = List<int>.from(map['results'][l]['numbers']);
          List<String> numberStrings = numbers.map((num) => num.toString()).toList();

          List<int> bonus = List<int>.from(map['results'][l]['bonus']);
          List<String> bonusStrings = bonus.map((num) => num.toString()).toList();

          int prize = lotteryService.checkPrize(lottoName, numberStrings, bonusStrings, results);
          rankList.add(prize);
        }
      }
    }
    return rankList;
  }

  Future<List<Map<String, dynamic>>> fetchLottoResults(List<Map<String, dynamic>> _allGeneratedNumbers) async {
    try {
      List<Map<String, dynamic>> results = [];
      for (int i = 0; i < _allGeneratedNumbers.length; i++) {
        Map<String, dynamic> result = await lotteryService.getLottoResults(lottos[i]);
        results.add(result);
      }
      return results;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
Widget build(BuildContext context) {
  return (isResultLoading || isPrizeLoading || isDataLoading)
      ? Center(child: CircularProgressIndicator(color: Colors.white))
      : Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          body: Expanded(child: 
            Column(children:[ 
                Row(
            children: [
              Container(
            padding: EdgeInsets.only(left: 10, top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 28, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
            ],
          ),
                Expanded ( child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 40),
                      // Container(
                      //   padding: EdgeInsets.all(10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       IconButton(
                      //         icon: Icon(Icons.arrow_back, size: 28, color: Colors.black),
                      //         onPressed: () async {
                      //           Navigator.pop(context);
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.red,
                              size: 32,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "latestLottoResult".tr(),
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: _allGeneratedNumbers.map((lottery) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(),
                                    Row(
                                      children: [
                                        Icon(Icons.confirmation_number, color: Colors.blue, size: 28),
                                        SizedBox(width: 10),
                                        Expanded( // Wrapping Text with Expanded
                                          child: Text(
                                            tr(lottery['title']),
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            overflow: TextOverflow.ellipsis, // Handling overflow with ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      children: lottery['results'].map<Widget>((result) {
                                        if (cnt < rankList.length - 1) {
                                          cnt++;
                                        }
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.date_range, color: Colors.green),
                                                SizedBox(width: 5),
                                                Text("resultFrom".tr() + ": "),
                                                Text(timeResults[cnt].toString(), style: TextStyle(fontWeight: FontWeight.bold))
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text("picked".tr() + ": "),
                                                    Wrap(
                                                      spacing: 10,
                                                      children: [
                                                        ...result['numbers'].map<Widget>((number) {
                                                          return Chip(
                                                            label: Text(
                                                              number.toString(),
                                                              style: TextStyle(
                                                                fontFamily: 'Roboto',
                                                                fontSize: 16,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                            backgroundColor: Colors.blue,
                                                            shape: StadiumBorder(side: BorderSide(color: Colors.blueAccent)),
                                                            elevation: 3,
                                                            shadowColor: Colors.black45,
                                                          );
                                                        }).toList(),
                                                        ...result['bonus'].map<Widget>((number) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                "+",
                                                                style: TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.red,
                                                                ),
                                                              ),
                                                              Chip(
                                                                label: Text(
                                                                  number.toString(),
                                                                  style: TextStyle(
                                                                    fontFamily: 'Roboto',
                                                                    fontSize: 16,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                                backgroundColor: Colors.yellow,
                                                                shape: StadiumBorder(side: BorderSide(color: Colors.yellowAccent)),
                                                                elevation: 3,
                                                                shadowColor: Colors.black45,
                                                              )
                                                            ],
                                                          );
                                                        }).toList(),
                                                      ]
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 20),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.money, color: Colors.amber),
                                                  SizedBox(width: 5),
                                                  Text("prize".tr() + ": "),
                                                  rankList[cnt] == -1
                                                  ? Text(
                                                      "noPrize".tr(),
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  : Text(
                                                      "prize".tr() + ": ${prizeList[cnt][rankList[cnt]].toString()}",
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Divider()
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  )
                  ),
                ),
                // BannerAdPage1()
              ]
            )
          ),
        );
      }
}
