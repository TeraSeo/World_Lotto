import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottery_kr/service/LotteryService.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:textfield_tags/textfield_tags.dart';

class NumberGenerator extends StatefulWidget {
  final Map<String, dynamic> lottoData;
  const NumberGenerator({super.key, required this.lottoData});

  @override
  State<NumberGenerator> createState() => _NumberGeneratorState();
}

class _NumberGeneratorState extends State<NumberGenerator> {
  LotteryService lotteryService = LotteryService();
  NumberGenerateService numberGenerateService = NumberGenerateService();

  List<int> _lottoNumbers = [];
  List<int> _bonusNumber = [];
  List<Map<String, List<int>>> _allGeneratedNumbers = [];
  bool isDataLoading = true;
  List<String> tags = [];
  List<String> manuals = [];
  late StringTagController _stringTagController;
  late StringTagController _manualTagController;
  late PageController controller;

  bool isNumbersLoading = true;
  bool isOnWifi = false;

  final List<String> items = [
    "automatic".tr(),
    "manual".tr(),
  ];
  String selectedValue = "automatic".tr();

  List<List<dynamic>> shownNumbers = [];
  List<String> shownTexts = ["mostCommon".tr(), "worstCommon".tr()];

  int currentLimit = 0;
  bool isLimitLoading = true;

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
    _manualTagController = StringTagController();
    controller = PageController(viewportFraction: 1, keepPage: true);
    Future.delayed(Duration(seconds: 0)).then((value) async {
      getNumberLimit();
      isOnWifi = await InternetConnection().hasInternetAccess;
      if (isOnWifi) {
        List<List<dynamic>> numbers = await lotteryService.getMostWorstShownNumbers(widget.lottoData["dbTitle"]);
        shownNumbers.add(numbers[0]);
        shownNumbers.add(numbers[1]);
        shownNumbers.add(numbers[2]);
        shownNumbers.add(numbers[3]);
        if (this.mounted) {
          setState(() {
            isNumbersLoading = false;
          });
        }
      }
      else {
        if (this.mounted) {
          setState(() {
            isNumbersLoading = false;
          });
        }
      }
    });
    _loadData();
  }

  @override
  void dispose() {
    _stringTagController.dispose();
    _manualTagController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isDataLoading || isNumbersLoading || isLimitLoading) ? const Center(child: CircularProgressIndicator()) : Container(
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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, size: 28, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
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
                            widget.lottoData["dbTitle"].toString().tr(),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.grey[850],
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: Text(
                            "save".tr(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            _saveData().then((value) async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('lotteryNumberSaved'.tr()),
                                )
                              );
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              bool isReviewed = prefs.getBool("isReviewMade") ?? false;
                              if (!isReviewed) {
                                try {
                                  final inAppReview = InAppReview.instance;
                                  if (await inAppReview.isAvailable()) {
                                    inAppReview.requestReview();
                                  }
                                  else {
                                    showReviewDialog();
                                  }
                                  prefs.setBool("isReviewMade", true);
                                } catch(e) {
                                  print(e.toString());
                                  prefs.setBool("isReviewMade", true);
                                }
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: _buildHistoryCard(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Column(
              children: [
                selectedValue == "automatic".tr() ?
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey[850],
                    padding: EdgeInsets.symmetric(horizontal: 100),
                  ),
                  child: Text(
                    "pickNumber".tr(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _generateLottoNumbers();
                  },
                ) :
                _buildManualNumbersInput()
              ],
            ),
          ),
        ],
      ),
      )
    );
  }

  Widget _buildHistoryCard() {

    final pages = List.generate(
      2,
      (index) => Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.grey.shade300, Colors.grey.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shownTexts[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              isOnWifi ?
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                      children: 
                        [
                          Wrap(
                            spacing: 10,
                            children: List.generate(
                              shownNumbers[index * 2].length, 
                              (i) {
                                return _buildNumberBall(int.parse(shownNumbers[index * 2][i]));
                              },
                            ),
                          )
                        ]
                    ),
                    shownNumbers[index * 2 + 1].length > 0 ?
                    Text("  +  ") : Text(""),
                    Row(
                      children: 
                        [
                          Wrap(
                            children: List.generate(
                              shownNumbers[index * 2 + 1].length, 
                              (i) {
                                return _buildNumberBall(int.parse(shownNumbers[index * 2 + 1][i]));
                              },
                            ),
                          )
                        ]
                    )
                  ],
                ),
              ) : Text("requireWifi".tr())
            ],
          ),
        ),
      ),
    );

    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "numList".tr(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                dropdownButton()
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildExcludedNumbersInput(),
                    SizedBox(
                      height: 140,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: pages.length,
                        itemBuilder: (_, index) {
                          return pages[index % pages.length];
                        },
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: controller,
                      count: pages.length,
                      effect: const WormEffect(
                        dotHeight: 9,
                        dotWidth: 9,
                        type: WormType.thinUnderground,
                      ),
                    ),
                    Column(
                      children: List.generate(
                        _allGeneratedNumbers.length, 
                        (index) {
                          return Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 5),
                                      child: Wrap(
                                        spacing: 8.0, // Gap between each ball
                                        children: _allGeneratedNumbers[index]['numbers']!.map((number) => _buildNumberBall(number)).toList(),
                                      ),
                                    ),
                                    _allGeneratedNumbers[index]['bonus']!.length > 0 ? Container(child: Text("+", style: TextStyle(fontWeight: FontWeight.bold),), margin: EdgeInsets.symmetric(horizontal: 10),) : Text(""),
                                    if (_allGeneratedNumbers[index]['bonus']!.isNotEmpty)
                                      Wrap(
                                        spacing: 8.0, // Gap between each ball
                                        children: _allGeneratedNumbers[index]['bonus']!.map((number) => _buildBonusBall(number)).toList(),
                                      ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: Colors.red[500], // Custom color for the button background
                                          shape: BoxShape.rectangle, // Circle shape
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 1), // Adds soft shadow
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(25), // Ensure the ripple effect is circular
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.close, size: 20, color: Colors.white), // Smaller icon with white color for contrast
                                          ),
                                          onTap: () => _removeNumberSet(index),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      )
                    ),
                  ],
                )
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_allGeneratedNumbers.length.toString() + "/" + currentLimit.toString(), style: TextStyle(color: Colors.black54))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _removeNumberSet(int index) {
    setState(() {
      _allGeneratedNumbers.removeAt(index);
    });
  }

  Widget _buildNumberBall(int number) {
    return Container(
        width: 35, // Diameter of the ball
        height: 35, // Diameter of the ball
        decoration: BoxDecoration(
          color: getColorForNumber(number), // Dynamic color based on the number
          shape: BoxShape.circle, // Make it round
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1), // Shadow position
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          number.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
    );
  }

  Widget _buildBonusBall(int number) {
    return Container(
        width: 35, // Diameter of the ball
        height: 35, // Diameter of the ball
        decoration: BoxDecoration(
          color: Colors.yellow[700], // Yellow color for bonus ball
          shape: BoxShape.circle, // Make it round
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1), // Shadow position
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          number.toString(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
    );
  }

  Color getColorForNumber(int number) {
    if (number <= 9) {
      return Colors.red[400]!;
    } else if (number <= 18) {
      return Colors.blue[400]!;
    } else if (number <= 27) {
      return Colors.green[400]!;
    } else if (number <= 36) {
      return Colors.orange[400]!;
    } else if (number <= 45) {
      return Colors.purple[400]!;
    } else if (number <= 54) {
      return Colors.yellow[600]!;
    } else if (number <= 63) {
      return Colors.cyan[400]!;
    } else if (number <= 72) {
      return Colors.pink[400]!;
    } else if (number <= 81) {
      return Colors.teal[400]!;
    } else {
      return Colors.brown[400]!;
    }
  }

  Widget _buildExcludedNumbersInput() {
    return TextFieldTags<String>(
      textfieldTagsController: _stringTagController,
      initialTags: tags,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (_stringTagController.getTags!.length > 20) {
            return "numbersAlot".tr();
        }
        if (_stringTagController.getTags!.contains(tag)) {
            return "numberDuplicated".tr();
        }
        if (int.tryParse(tag) == null) {
            return "enterValidNumber".tr();
        }
        return null;
      },
      inputFieldBuilder: (context, inputFieldValues) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            onTap: () {
              _stringTagController.getFocusNode?.requestFocus();
            },
            controller: inputFieldValues.textEditingController,
            focusNode: inputFieldValues.focusNode,
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 74, 137, 92),
                  width: 3.0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 74, 137, 92),
                  width: 3.0,
                ),
              ),
              helperText: "exceptBonus".tr(),
              helperStyle: const TextStyle(
                color: Color.fromARGB(255, 74, 137, 92),
              ),
              hintText: inputFieldValues.tags.isNotEmpty
                  ? ''
                  : "excludeNumber".tr(),
              errorText: inputFieldValues.error,
              prefixIconConstraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
              prefixIcon: inputFieldValues.tags.isNotEmpty
                  ? SingleChildScrollView(
                      controller: inputFieldValues.tagScrollController,
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: 8,
                        ),
                        child: Wrap(
                            runSpacing: 4.0,
                            spacing: 4.0,
                            children:
                                inputFieldValues.tags.map((String tag) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color:
                                      Color.fromARGB(255, 74, 137, 92),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '#$tag',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () {
                                        //print("$tag selected");
                                      },
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color: Color.fromARGB(
                                            255, 233, 233, 233),
                                      ),
                                      onTap: () {
                                        inputFieldValues
                                            .onTagRemoved(tag);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }
                            ).toList()),
                      ),
                    )
                  : null,
            ),
            onChanged: inputFieldValues.onTagChanged,
            onSubmitted: inputFieldValues.onTagSubmitted,
          ),
        );
      },
    );
  }

  Widget _buildManualNumbersInput() {
    return Row(
      children: [
        Expanded(
          child: TextFieldTags<String>(
            textfieldTagsController: _manualTagController,
            initialTags: manuals,
            textSeparators: const [' ', ','],
            letterCase: LetterCase.normal,
            validator: (String tag) {
              if (int.tryParse(tag) == null) {
                return "enterValidNumber".tr();
              }
              String res = numberGenerateService.checkNumberCondition(widget.lottoData["dbTitle"], _manualTagController, tag);
              if (res != "") return res;
              return null;
            },
            inputFieldBuilder: (context, inputFieldValues) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  onTap: () {
                    _manualTagController.getFocusNode?.requestFocus();
                  },
                  controller: inputFieldValues.textEditingController,
                  focusNode: inputFieldValues.focusNode,
                  decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 74, 137, 92),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 74, 137, 92),
                        width: 3.0,
                      ),
                    ),
                    helperStyle: const TextStyle(
                      color: Color.fromARGB(255, 74, 137, 92),
                    ),
                    hintText: inputFieldValues.tags.isNotEmpty
                        ? ''
                        : "manualNumberInput".tr(),
                    errorText: inputFieldValues.error,
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    prefixIcon: inputFieldValues.tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: inputFieldValues.tagScrollController,
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                left: 8,
                              ),
                              child: Wrap(
                                  runSpacing: 4.0,
                                  spacing: 4.0,
                                  children: inputFieldValues.tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Color.fromARGB(255, 74, 137, 92),
                                      ),
                                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '#$tag',
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            onTap: () {
                                              //print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              inputFieldValues.onTagRemoved(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                            ),
                          )
                        : null,
                  ),
                  onChanged: inputFieldValues.onTagChanged,
                  onSubmitted: inputFieldValues.onTagSubmitted,
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              switch(widget.lottoData["dbTitle"]) {
                case "usPowerballNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                      setState(() {
                        _lottoNumbers.clear();
                        _bonusNumber.clear();
                        List<String> numbers = _manualTagController.getTags!;
                        if (numbers.length == 6) {
                          for (int i = 0; i < 5; i++) {
                            _lottoNumbers.add(int.parse(numbers[i]));
                          }
                          String bonusNumber = numbers[5];
                          _bonusNumber.add(int.parse(bonusNumber)); 
                        }
                        else {
                          for (int i = 0; i < numbers.length; i++) {
                            _lottoNumbers.add(int.parse(numbers[i]));
                          }
                          Random random = Random();
                          while (_lottoNumbers.length < 5) {
                            int nextNumber = random.nextInt(69) + 1;  // Generate a number between 1 and 69
                            if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                              _lottoNumbers.add(nextNumber);
                            }
                          }
                          int powerball;
                          powerball = random.nextInt(26) + 1;
                          _bonusNumber.add(powerball); 
                        }
                        _lottoNumbers.sort();
                        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                      });
                    }
                  break;
                case "megaMillionNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (numbers.length == 6) {
                        for (int i = 0; i < 5; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        String bonusNumber = numbers[5];
                        _bonusNumber.add(int.parse(bonusNumber)); 
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 5) {
                          int nextNumber = random.nextInt(70) + 1;  // Generate a number between 1 and 69
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                        int megaBall;
                        megaBall = random.nextInt(25) + 1;
                        _bonusNumber.add(megaBall); 
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                    });
                  }
                  break;
                case "ausPowerBallNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (numbers.length == 8) {
                        for (int i = 0; i < 7; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        String bonusNumber = numbers[7];
                        _bonusNumber.add(int.parse(bonusNumber)); 
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 7) {
                          int nextNumber = random.nextInt(35) + 1;  // Generate a number between 1 and 69
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                        int bonus;
                        bonus = random.nextInt(20) + 1;
                        _bonusNumber.add(bonus); 
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                    });
                  }
                  break;
                case "euroMillionNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                      setState(() {
                        _lottoNumbers.clear();
                        _bonusNumber.clear();
                        List<String> numbers = _manualTagController.getTags!;
                        if (numbers.length == 7) {
                          for (int i = 0; i < 5; i++) {
                            _lottoNumbers.add(int.parse(numbers[i]));
                          }
                          _lottoNumbers.sort();
                          String bonusNumber1 = numbers[5];
                          String bonusNumber2 = numbers[6];
                          _bonusNumber.add(int.parse(bonusNumber1)); 
                          _bonusNumber.add(int.parse(bonusNumber2)); 
                          if (bonusNumber1 != bonusNumber2) _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                        }
                        else {
                          for (int i = 0; i < numbers.length; i++) {
                            _lottoNumbers.add(int.parse(numbers[i]));
                          }
                          Random random = Random();
                          while (_lottoNumbers.length < 5) {
                            int nextNumber = random.nextInt(50) + 1;  // Generate a number between 1 and 69
                            if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                              _lottoNumbers.add(nextNumber);
                            }
                          }
                          _lottoNumbers.sort();
                          List<int> luckyStars = [];
                          for (int i = 5; i < numbers.length; i++) {
                            luckyStars.add(int.parse(numbers[i]));
                          }
                          while (luckyStars.length < 2) {
                            int nextStar;
                            nextStar = random.nextInt(12) + 1;  
                            if (!luckyStars.contains(nextStar)) luckyStars.add(nextStar);
                          }
                          _bonusNumber.addAll(luckyStars); 
                          _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                        }
                      });
                    }
                  break;
                case "euroJackpotNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                      setState(() {
                        _lottoNumbers.clear();
                        _bonusNumber.clear();
                        List<String> numbers = _manualTagController.getTags!;
                        if (numbers.length == 7) {
                          for (int i = 0; i < 5; i++) {
                            _lottoNumbers.add(int.parse(numbers[i]));
                          }
                          _lottoNumbers.sort();
                          String bonusNumber1 = numbers[5];
                          String bonusNumber2 = numbers[6];
                          _bonusNumber.add(int.parse(bonusNumber1)); 
                          _bonusNumber.add(int.parse(bonusNumber2)); 
                          if (bonusNumber1 != bonusNumber2) _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                        }
                        else {
                          for (int i = 0; i < numbers.length; i++) {
                            _lottoNumbers.add(int.parse(numbers[i]));
                          }
                          Random random = Random();
                          while (_lottoNumbers.length < 5) {
                            int nextNumber = random.nextInt(50) + 1;  // Generate a number between 1 and 69
                            if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                              _lottoNumbers.add(nextNumber);
                            }
                          }
                          _lottoNumbers.sort();
                          List<int> luckyStars = [];
                          for (int i = 5; i < numbers.length; i++) {
                            luckyStars.add(int.parse(numbers[i]));
                          }
                          while (luckyStars.length < 2) {
                            int nextStar;
                            nextStar = random.nextInt(12) + 1;  
                            if (!luckyStars.contains(nextStar)) luckyStars.add(nextStar);
                          }
                          _bonusNumber.addAll(luckyStars); 
                          _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                        }
                      });
                    }
                  break;
                case "ukLotto":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (numbers.length == 6) {
                        for (int i = 0; i < 6; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 6) {
                          int nextNumber = random.nextInt(59) + 1;
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
                    });
                  }
                  break;
                case "superEnalottoNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (numbers.length == 7) {
                        for (int i = 0; i < 6; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        String bonusNumber = numbers[6];
                        _bonusNumber.add(int.parse(bonusNumber)); 
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 6) {
                          int nextNumber = random.nextInt(90) + 1;
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                        int jollyNumber;
                        jollyNumber = random.nextInt(90) + 1;
                        _bonusNumber.add(jollyNumber); 
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                    });
                  }
                  break;
                case "jLottoNumber_1":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (_manualTagController.getTags!.length == 6) {
                        for (int i = 0; i < 6; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 6) {
                          int nextNumber = random.nextInt(43) + 1;
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
                    });
                  }
                  break;
                case "jLottoNumber_2":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (_manualTagController.getTags!.length == 7) {
                        for (int i = 0; i < 7; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 7) {
                          int nextNumber = random.nextInt(37) + 1;
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
                    });
                  }
                  break;
                case "kLottoNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (_manualTagController.getTags!.length == 6) {
                        for (int i = 0; i < 6; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 6) {
                          int nextNumber = random.nextInt(45) + 1;
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
                    });
                  }
                  break;
                case "laPrimitivaNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (_manualTagController.getTags!.length == 7) {
                        for (int i = 0; i < 6; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        String bonusNumber = numbers[6];
                        _bonusNumber.add(int.parse(bonusNumber)); 
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 6) {
                          int nextNumber = random.nextInt(49) + 1;
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                        _bonusNumber.add(random.nextInt(9) + 1); 
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                    });
                  }
                  break;
                case "elGordoNumber":
                  if (_allGeneratedNumbers.length < currentLimit) {
                    setState(() {
                      _lottoNumbers.clear();
                      _bonusNumber.clear();
                      List<String> numbers = _manualTagController.getTags!;
                      if (_manualTagController.getTags!.length == 6) {
                        for (int i = 0; i < 5; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        String bonusNumber = numbers[5];
                        _bonusNumber.add(int.parse(bonusNumber)); 
                      }
                      else {
                        for (int i = 0; i < numbers.length; i++) {
                          _lottoNumbers.add(int.parse(numbers[i]));
                        }
                        Random random = Random();
                        while (_lottoNumbers.length < 5) {
                          int nextNumber = random.nextInt(54) + 1;
                          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
                            _lottoNumbers.add(nextNumber);
                          }
                        }
                        _bonusNumber.add(random.nextInt(9) + 1);
                      }
                      _lottoNumbers.sort();
                      _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
                    });
                  }
                  break;
                default:
                  break;
              }
            });
          },
          child: Text("confirm".tr()),
        ),
      ],
    );
  }

  Widget dropdownButton() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          selectedValue,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            if (value == "manual".tr() && selectedValue != "manual".tr()) _manualTagController = StringTagController();
            selectedValue = value!;
          });
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }

  void showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("review".tr()),
          content: Platform.isAndroid ? Text("askAndroidReview".tr()) : Text("askIOSReview".tr()),
          actions: <Widget>[
            TextButton(
              child: Text("no".tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("yes".tr()),
              onPressed: () async {
                Navigator.of(context).pop();
                final inAppReview = InAppReview.instance;
                inAppReview.openStoreListing(
                  appStoreId: '6505033228',
                );
              },
            ),
          ],
        );
    });
  }

  void _generateLottoNumbers() {
    tags = _stringTagController.getTags!;
    switch(widget.lottoData["dbTitle"]) {
      case "usPowerballNumber":
        _generateUSPowerballNumbers();
        break;
      case "megaMillionNumber":
        _generateMegaMillionNumbers();
        break;
      case "euroMillionNumber":
        _generateEuroMillionNumbers();
        break;
      case "euroJackpotNumber":
        _generateEuroJackpotNumbers();
      case "ukLotto":
        _generateUkLottoNumbers();
      case "laPrimitivaNumber":
        _generateLaPrimitivaNumbers();
        break;
      case "elGordoNumber":
        _generateElGordoNumbers();
        break;
      case "superEnalottoNumber":
        _generateSuperEnalottoNumbers();
        break;
      case "ausPowerBallNumber":
        _generateAustraliaPowerballNumbers();
        break;
      case "kLottoNumber":
        _generateLotto6_45Numbers();
        break;
      case "jLottoNumber_1":
        _generateLotto6Numbers();
        break;
      case "jLottoNumber_2":
        _generateLotto7Numbers();
        break;
      default:
        return;
    }
  }

  void getNumberLimit() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (this.mounted) {
        setState(() {
          currentLimit = prefs.getInt('numberLimit') ?? 20;
          isLimitLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _generateUSPowerballNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 5) {
          int nextNumber = random.nextInt(69) + 1;  // Generate a number between 1 and 69
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        int powerball;
        powerball = random.nextInt(26) + 1;  // Generate the Powerball number between 1 and 26
        _bonusNumber.add(powerball);  // Add the Powerball number as bonus number
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateMegaMillionNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 5) {
          int nextNumber = random.nextInt(70) + 1;  // Generate a number between 1 and 70
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        int megaBall;
        megaBall = random.nextInt(25) + 1;  // Generate the MegaBall number between 1 and 25
        _bonusNumber.add(megaBall);  // Add the MegaBall number as bonus number
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateEuroMillionNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 5) {
          int nextNumber = random.nextInt(50) + 1;  // Generate a number between 1 and 50
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        List<int> luckyStars = [];
        // Generate Lucky Stars ensuring they are not in the main numbers and are unique
        while (luckyStars.length < 2) {
          int nextStar;
          nextStar = random.nextInt(12) + 1;  // Generate a Lucky Star number between 1 and 12
          if (!luckyStars.contains(nextStar)) luckyStars.add(nextStar);
        }

        _bonusNumber.addAll(luckyStars);  // Add the Lucky Stars as bonus numbers
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateEuroJackpotNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 5) {
          int nextNumber = random.nextInt(50) + 1;  // Generate a number between 1 and 50
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        List<int> euroNumbers = [];
        // Generate Lucky Stars ensuring they are not in the main numbers and are unique
        while (euroNumbers.length < 2) {
          int euroNumber;
          euroNumber = random.nextInt(12) + 1;  // Generate a Lucky Star number between 1 and 12
          if (!euroNumbers.contains(euroNumber)) euroNumbers.add(euroNumber);
        }

        _bonusNumber.addAll(euroNumbers);  // Add the Lucky Stars as bonus numbers
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateUkLottoNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 6) {
          int nextNumber = random.nextInt(59) + 1;  // Generate a number between 1 and 50
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
      });
    }
  }

  void _generateLaPrimitivaNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 6) {
          int nextNumber = random.nextInt(49) + 1;  // Generate a number between 1 and 49
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        int keyNumber;
        keyNumber = random.nextInt(9) + 1;  // Generate the Key Number between 0 and 9
        
        _bonusNumber.add(keyNumber);  // Add the Key Number as bonus number
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateElGordoNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 5) {
          int nextNumber = random.nextInt(54) + 1;  // Generate a number between 1 and 54
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        int keyNumber;
        keyNumber = random.nextInt(9) + 1;  // Generate the Key Number between 0 and 9
        
        _bonusNumber.add(keyNumber);  // Add the Key Number as bonus number
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateSuperEnalottoNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();

        // Generate 6 unique main numbers
        while (_lottoNumbers.length < 6) {
          int nextNumber = random.nextInt(90) + 1;  // Numbers from 1 to 90
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        
        // Optionally generate a Jolly number, which must be unique from the main numbers
        int jollyNumber;
        jollyNumber = random.nextInt(90) + 1;  // Also from 1 to 90

        // Add the Jolly number to the bonus number list
        _bonusNumber.add(jollyNumber);

        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateAustraliaPowerballNumbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 7) {
          int nextNumber = random.nextInt(35) + 1;  // Generate a number between 1 and 35
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        int powerball;
        powerball = random.nextInt(20) + 1;  // Generate the Powerball number between 1 and 20
        
        _bonusNumber.add(powerball);  // Add the Powerball number as bonus number
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': List.from(_bonusNumber)});
      });
    }
  }

  void _generateLotto6_45Numbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 6) {
          int nextNumber = random.nextInt(45) + 1;  // Generate a number between 1 and 45
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        // No bonus number for this lottery
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
      });
    }
  }

  void _generateLotto6Numbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 6) {
          int nextNumber = random.nextInt(43) + 1;  // Generate a number between 1 and 43
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        // No bonus number for this lottery
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
      });
    }
  }

  void _generateLotto7Numbers() {
    if (_allGeneratedNumbers.length < currentLimit) {
      setState(() {
        _lottoNumbers.clear();
        _bonusNumber.clear();
        Random random = Random();
        while (_lottoNumbers.length < 7) {
          int nextNumber = random.nextInt(37) + 1;  // Generate a number between 1 and 37
          if (!_lottoNumbers.contains(nextNumber) && !_stringTagController.getTags!.contains(nextNumber.toString())) {
            _lottoNumbers.add(nextNumber);
          }
        }
        _lottoNumbers.sort();
        // No bonus number for this lottery
        _allGeneratedNumbers.add({'numbers': List.from(_lottoNumbers), 'bonus': []});
      });
    }
  }

  Future _saveData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> stringList = _allGeneratedNumbers.map((map) {
        String numbers = map['numbers']!.join(",");
        String bonus = map['bonus']!.isEmpty ? "" : ";" + map['bonus']!.join(",");
        return numbers + bonus;
      }).toList();
      await prefs.setStringList(widget.lottoData["dbTitle"], stringList);
    } catch (e) {
      debugPrint('Failed to save data: $e');
    }
  }

  void _loadData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> stringList = prefs.getStringList(widget.lottoData["dbTitle"]) ?? [];
      setState(() {
        _allGeneratedNumbers = stringList.map((str) {
          List<String> parts = str.split(";");
          List<int> numbers = parts[0].split(",").map((num) => int.parse(num)).toList();
          List<int> bonus = parts.length > 1 ? parts[1].split(",").map((num) => int.parse(num)).toList() : [];
          return {'numbers': numbers, 'bonus': bonus};
        }).toList();
        isDataLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load data: $e');
      setState(() {
        isDataLoading = false;
      });
    }
  }
}
