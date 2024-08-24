import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/ads/BannerAdPage.dart';
import 'package:lottery_kr/tab/page/widget/LotteryInfo.dart';

class CompareLotto extends StatefulWidget {
  final List<Map<String, dynamic>> lotteryDetails;
  const CompareLotto({super.key, required this.lotteryDetails});

  @override
  State<CompareLotto> createState() => _CompareLottoState();
}

class _CompareLottoState extends State<CompareLotto> {

  String selectedSortOption = "highestPrize".tr(); 

  void _sortLotteryDetails() {
    if (selectedSortOption == "highestPrize".tr()) {
      widget.lotteryDetails.sort((a, b) => _extractHighestPrize(b['highestPrize'])
          .compareTo(_extractHighestPrize(a['highestPrize'])));
    } else if (selectedSortOption == 'prob'.tr()) {
      widget.lotteryDetails.sort((a, b) => _extractFirstPrizeProbability(b['probabilities'])
          .compareTo(_extractFirstPrizeProbability(a['probabilities'])));
    }
  }

  int _extractHighestPrize(String prize) {
    final extractedPrize = prize.split(": ")[1];
    int _prize = 0;
    if (extractedPrize[0] == "\$") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', ''));
      _prize = _prize * 1300;
    }
    else if (extractedPrize[0] == "₩") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', ''));
    }
    else if (extractedPrize[0] == "€") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', ''));
      _prize = _prize * 1500;
    }
    else if (extractedPrize[0] == "¥") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', ''));
      _prize = _prize * 10;
    }
    else if (extractedPrize[0] == "A") {
      _prize = int.parse(extractedPrize.substring(2).replaceAll(',', ''));
      _prize = _prize * 900;
    }
    else if (extractedPrize[0] == "£") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', ''));
      print(_prize);
      _prize = _prize * 1760;
    }
    return _prize;
  }

  double _extractFirstPrizeProbability(List<String> probabilities) {
    final firstPrizeProbability = probabilities[0];
    List<String> probabilityValues = firstPrizeProbability.split(': ')[1].replaceAll(',', '').split(' / ');
    return int.parse(probabilityValues[0]) / int.parse(probabilityValues[1]);
  }

  @override
  void initState() {
    super.initState();
    _sortLotteryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Column(
        children: [
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            "compareLotto".tr(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedSortOption,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSortOption = newValue!;
                                  _sortLotteryDetails();
                                });
                              },
                              items: <String>["highestPrize".tr(), 'prob'.tr()]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              dropdownColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: List.generate(widget.lotteryDetails.length,
                      (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: LotteryInfoCard(
                            lotteryDetails: {
                              "title": widget.lotteryDetails[index]["title"],
                              "highestPrize": widget.lotteryDetails[index]["highestPrize"],
                              "frequency": widget.lotteryDetails[index]["frequency"],
                              "ticketPrice": widget.lotteryDetails[index]["ticketPrice"],
                              "drawDate": widget.lotteryDetails[index]["drawDate"],
                              "purchasableArea": widget.lotteryDetails[index]["purchasableArea"],
                              "prizeDetails": List<String>.from(widget.lotteryDetails[index]["prizeDetails"]),
                              "winningMethods": List<String>.from(widget.lotteryDetails[index]["winningMethods"]),
                              "probabilities": List<String>.from(widget.lotteryDetails[index]["probabilities"])
                            },
                          ),
                        );
                      }
                    ),
                  )
                ]
              ),
              )
            )
          ),
          BannerAdPage(),
        ]
      )
    );
  }
}