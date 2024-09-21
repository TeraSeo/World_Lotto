import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:lottery_kr/ads/BannerAdPage.dart';
import 'package:lottery_kr/widget/LotteryInfo.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromARGB(255, 107, 59, 202),
                Color.fromARGB(255, 221, 81, 228),
                Color.fromARGB(255, 230, 119, 198),
                Color.fromARGB(255, 216, 97, 147),
                Color.fromARGB(255, 233, 105, 124),
                Color.fromARGB(255, 211, 142, 133),
                Color.fromARGB(255, 238, 172, 139),
                Color.fromARGB(255, 232, 188, 144),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
        child: Column(
        children: [
          Row(
            children: [
              Container(
            padding: EdgeInsets.only(left: screenWidth * 0.05, top: screenHeight * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: screenWidth * 0.07, color: Colors.white),
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                          size: screenWidth * 0.08,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Text(
                            "compareLotto".tr(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
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
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 1),
                                  colors: <Color>[
                                    Color.fromARGB(255, 221, 81, 228),
                                    Color.fromARGB(255, 230, 119, 198),
                                    Color.fromARGB(255, 216, 97, 147),
                                    Color.fromARGB(255, 233, 105, 124),
                                  ],
                                  tileMode: TileMode.mirror,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: Offset(2, 4),
                                  ),
                                ],
                              ),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              height: screenHeight * 0.06,
                            ),
                            iconStyleData: IconStyleData(iconEnabledColor: Colors.black),
                            dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 1),
                                  colors: <Color>[
                                    Color.fromARGB(255, 221, 81, 228),
                                    Color.fromARGB(255, 230, 119, 198),
                                    Color.fromARGB(255, 216, 97, 147),
                                    Color.fromARGB(255, 233, 105, 124),
                                  ],
                                  tileMode: TileMode.mirror,
                                ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(2, 4),
                                ),
                              ],
                            )),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
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
                          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.013),
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
          // BannerAdPage(),
        ]
      ),
      )
    );
  }
}