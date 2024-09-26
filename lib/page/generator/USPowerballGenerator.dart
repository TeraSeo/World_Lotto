import 'package:flutter/material.dart';
import 'package:lottery_kr/page/generator/BuildOwnNumberGenerator.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/widget/buttons/BuildOwnButton.dart';
import 'package:lottery_kr/widget/buttons/NumberGenerateButton.dart';
import 'package:lottery_kr/widget/buttons/QuickPlayButton.dart';
import 'package:lottery_kr/widget/item/LotteryBonusBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberBall.dart';
import 'package:lottery_kr/widget/item/LotteryNumberRow.dart';
import 'package:lottery_kr/widget/item/LotteryReintegro.dart';
import 'package:lottery_kr/widget/item/MostWorstShownNumbersTable.dart';
import 'package:lottery_kr/widget/texts/LotteryCardTitleText.dart';
import 'package:lottery_kr/widget/texts/PrizeStatusText.dart';

class USPowerballGenerator extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  final Map<String, dynamic> lotteryData;
  const USPowerballGenerator({super.key, required this.lotteryDetails, required this.lotteryData});

  @override
  State<USPowerballGenerator> createState() => _USPowerballGeneratorState();
}

class _USPowerballGeneratorState extends State<USPowerballGenerator> {

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
          isNumbersLoading = false;
        }
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

    return Container(
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
                    Navigator.pop(context);
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
                  return LotteryNumberRow(index: index + 1, number: numbers[index], backgroundColor: widget.lotteryDetails["backgroundColor"], removeNumberByIndex: removeNumberByIndex);
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
    );
  }

  Future<void> showBuildOwnNumberDialog(
    BuildContext context
  ) async {
    NumberGenerateService numberGenerateService = NumberGenerateService();
    int numberBallCount = numberGenerateService.getNumberOfBalls(widget.lotteryDetails["dbTitle"]);

    Map<String, List<dynamic>> result = {};

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, icon: Icon(Icons.cancel_outlined, color: Colors.white,))
                ],
              ),
              Container(margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025), child: MostWorstShownNumbersTable(lotteryData: widget.lotteryDetails)),
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: widget.lotteryDetails["color"],
                      tileMode: TileMode.mirror,
                    ),
                    borderRadius: BorderRadius.circular(20), 
                  ),
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                  child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: widget.lotteryDetails["dialogTopColor"],
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20), 
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                    "Your Current Selection",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: screenHeight * 0.021,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: List.generate(5, (index) {
                                            return LotteryNumberBall(number: "");
                                          }),
                                        ),
                                        Row(
                                          children: List.generate(1, (index) {
                                            return LotteryBonusBall(number: "");
                                          }),
                                        ),
                                        Row(
                                          children: List.generate(1, (index) {
                                            return LotteryReintegroBall(number: "");
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7, 
                                crossAxisSpacing: 10,
                              ),
                              itemCount: numberBallCount,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return LotteryNumberBall(number: "${index + 1}");
                              },
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: widget.lotteryDetails["dialogButtonColor"],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                          ),
                          height: screenHeight * 0.07,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: 
                          MaterialButton(
                            onPressed: () {
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Select Numbers", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            )
                          )
                        )
                      ],
                    ),
                )
              )
            ],
          ),
        );
      },
    );
  }
}