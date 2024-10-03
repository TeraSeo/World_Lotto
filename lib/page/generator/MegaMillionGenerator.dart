import 'package:flutter/material.dart';
import 'package:lottery_kr/page/generator/BuildOwnNumberGenerator.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/widget/buttons/BuildOwnButton.dart';
import 'package:lottery_kr/widget/buttons/NumberGenerateButton.dart';
import 'package:lottery_kr/widget/buttons/QuickPlayButton.dart';
import 'package:lottery_kr/widget/item/LotteryNumberRow.dart';
import 'package:lottery_kr/widget/item/MostWorstShownNumbersTable.dart';
import 'package:lottery_kr/widget/texts/LotteryCardTitleText.dart';
import 'package:lottery_kr/widget/texts/PrizeStatusText.dart';

class MegaMillionGenerator extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  const MegaMillionGenerator({super.key, required this.lotteryDetails, required  this.lotteryData});

  @override
  State<MegaMillionGenerator> createState() => _MegaMillionGeneratorState();
}

class _MegaMillionGeneratorState extends State<MegaMillionGenerator> {
  NumberGenerateService numberGenerateService = NumberGenerateService();
  LotteryService lotteryService = LotteryService();

  final ScrollController _scrollController = ScrollController();
  List<Map<String, List<dynamic>>> numbers = [];

  List<int> normalNumbers = [];
  List<int> bonusNumbers = [];
  List<int> reintegroNumbers = [];

  bool isNumbersLoading = true;
  bool isQuickPlay = false;
  bool isBuildOwn = false;

  @override
  void initState() {
    super.initState();
    loadNumbers();
  }

  void loadNumbers() {
    lotteryService.loadNumbers(widget.lotteryDetails["lottoName"]).then((value) {
      setState(() {
        if (value != null) {
          numbers = value;
        }
        isNumbersLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    lotteryService.saveNumbers(widget.lotteryDetails["lottoName"], numbers);
  }

  void setQuickPlayTrue() {
    setState(() {
      isQuickPlay = true;
    });
  }

  void setQuickPlayFalse() {
    setState(() {
      isQuickPlay = false;
    });
  }

  void buildOwnNumber() {
    lotteryService.saveNumbers(widget.lotteryDetails["lottoName"], numbers);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuildOwnNumberGenerator(lotteryDetails: widget.lotteryDetails, lotteryData: widget.lotteryData)),
    );
  }

  void addNormalNumber(int number) {
    setState(() {
      normalNumbers.add(number);
    });
  }

  void addBonusNumber(int number) {
    setState(() {
      bonusNumbers.add(number);
    });
  }

  void addReintegroNumber(int number) {
    setState(() {
      reintegroNumbers.add(number);
    });
  }

  void generateByLottoName() {
    Map<String, List<int>>? number = numberGenerateService.generateNumberByLottoName(widget.lotteryDetails["lottoName"]);
    if (number != null) {
      setState(() {
        numbers.add(number);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void removeNumberByIndex(int index) {
    setState(() {
      numbers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return WillPopScope(
      child: Container(
        padding: EdgeInsets.only(
          top: screenHeight * 0.08,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: widget.lotteryDetails["color"],
            tileMode: TileMode.mirror,
          ),
        ),
        child: isNumbersLoading ? const Center(child: CircularProgressIndicator(color: Colors.white)) : Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: screenHeight * 0.03, color: Colors.white),
                    onPressed: () {
                      numberGenerateService.popGeneratorPage(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.006),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LotteryCardTitleText(title: widget.lotteryDetails["lottoName"]),
                  PrizeStatusText(date: widget.lotteryData["nextDate"], prize: widget.lotteryData["jackpot"])
                ],
              ),
            ),
            MostWorstShownNumbersTable(lotteryData: widget.lotteryDetails),
            isQuickPlay ?
            SizedBox(height: screenHeight * 0.005):
            SizedBox(height: screenHeight * 0.02),
            isQuickPlay ?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setQuickPlayFalse();
                  },
                  child: Icon(Icons.cancel_outlined, size: screenWidth * 0.05)
                )
              ],
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: screenWidth * 0.02),
                Text("Choose way to play:", style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: screenHeight * 0.017, fontWeight: FontWeight.w700),)
              ],
            ),
            isQuickPlay ?
            Container() :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuickPlayButton(buttonColor: widget.lotteryDetails["buttonColor"], setQuickPlayTrue: setQuickPlayTrue),
                SizedBox(width: screenWidth * 0.02),
                BuildOwnButton(buttonColor: widget.lotteryDetails["buttonColor"], buildOwnNumber: buildOwnNumber),
              ],
            ),
            SizedBox(height: screenHeight * 0.032),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 221, 221),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: Offset(3, 6),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.008),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Number of Plays: ${numbers.length}", style: TextStyle(fontSize: screenHeight * 0.015, decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.w700)),
                  Text("Play cost: ＄${2.0 * numbers.length}", style: TextStyle(fontSize: screenHeight * 0.015, decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.w700))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: List.generate(numbers.length, (index) {
                    return LotteryNumberRow(index: index + 1, number: numbers[index], removeNumberByIndex: removeNumberByIndex, lotteryDetails: widget.lotteryDetails, lotteryData: widget.lotteryData);
                  }),
                ),
              )
            ),
            isQuickPlay ?
            SizedBox(
              height: screenHeight * 0.12,
              width: screenWidth * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NumberGenerateButton(lotteryDetails: widget.lotteryDetails, generateNumber: generateByLottoName)
                ],
              )
            ) :
            Container()
          ],
        ),
      ), 
      onWillPop: () async {
        return false;
      },
    );
  }
}