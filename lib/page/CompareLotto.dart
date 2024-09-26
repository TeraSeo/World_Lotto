import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/widget/LotteryInfo.dart';

class CompareLotto extends StatefulWidget {
  final List<Map<String, dynamic>> lotteryDetails;
  const CompareLotto({super.key, required this.lotteryDetails});

  @override
  State<CompareLotto> createState() => _CompareLottoState();
}

class _CompareLottoState extends State<CompareLotto> {
  String selectedSortOption = "highestPrize".tr();

  @override
  void initState() {
    super.initState();
    _sortLotteryDetails();
  }

  void _sortLotteryDetails() {
    if (selectedSortOption == "highestPrize".tr()) {
      widget.lotteryDetails.sort((a, b) =>
          _extractHighestPrize(b['highestPrize'])
              .compareTo(_extractHighestPrize(a['highestPrize'])));
    } else if (selectedSortOption == 'prob'.tr()) {
      widget.lotteryDetails.sort((a, b) =>
          _extractFirstPrizeProbability(b['probabilities'])
              .compareTo(_extractFirstPrizeProbability(a['probabilities'])));
    }
  }

  int _extractHighestPrize(String prize) {
    final extractedPrize = prize.split(": ")[1];
    int _prize = 0;
    if (extractedPrize[0] == "\$") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', '')) * 1300;
    } else if (extractedPrize[0] == "₩") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', ''));
    } else if (extractedPrize[0] == "€") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', '')) * 1500;
    } else if (extractedPrize[0] == "¥") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', '')) * 10;
    } else if (extractedPrize[0] == "A") {
      _prize = int.parse(extractedPrize.substring(2).replaceAll(',', '')) * 900;
    } else if (extractedPrize[0] == "£") {
      _prize = int.parse(extractedPrize.substring(1).replaceAll(',', '')) * 1760;
    }
    return _prize;
  }

  double _extractFirstPrizeProbability(List<String> probabilities) {
    final firstPrizeProbability = probabilities[0];
    List<String> probabilityValues = firstPrizeProbability
        .split(': ')[1]
        .replaceAll(',', '')
        .split(' / ');
    return int.parse(probabilityValues[0]) / int.parse(probabilityValues[1]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: screenHeight * 0.08,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2)
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: screenWidth * 0.02),
                Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                  size: screenWidth * 0.08,
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Text(
                    "compareLotto".tr(),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
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
                        color: Color(0xFFF2F2F2),
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
                        color: Color(0xFFF2F2F2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(widget.lotteryDetails.length, (index) {
                      return SizedBox(
                        child: LotteryInfoCard(
                          lotteryDetails: widget.lotteryDetails[index]
                        ),
                      );
                    })
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
