import 'package:flutter/material.dart';
import 'package:lottery_kr/service/NumberGenerateService.dart';
import 'package:lottery_kr/widget/item/GenerateNumberBall.dart';

class QuickGeneratePage extends StatefulWidget {
  final String dbTitle;
  final VoidCallback cancelButtonClicked;
  const QuickGeneratePage({super.key, required this.dbTitle, required this.cancelButtonClicked});

  @override
  State<QuickGeneratePage> createState() => _QuickGeneratePageState();
}

class _QuickGeneratePageState extends State<QuickGeneratePage> {

  NumberGenerateService numberGenerateService = NumberGenerateService();
  int ballNumbers = 0;

  @override
  void initState() {
    super.initState();
    getNumberOfBalls();
  }

  void getNumberOfBalls() {
    setState(() {
      ballNumbers = numberGenerateService.getNumberOfBalls(widget.dbTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      padding: EdgeInsets.only(left: screenWidth * 0.035, top: screenHeight * 0.02),
      width: screenWidth,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 242, 241, 241), borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.005, left: screenWidth * 0.02),
                child: Text("Numbers to Exclude", style: TextStyle(color: Colors.black, fontSize: screenHeight * 0.021, decoration: TextDecoration.none, fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.02),
                child: IconButton(onPressed: () {
                  widget.cancelButtonClicked();
                }, icon: Icon(Icons.cancel_outlined)),
              )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.4,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  (ballNumbers / 7).ceil(),
                  (rowIndex) {
                    final startIndex = rowIndex * 7;
                    final endIndex = (startIndex + 7).clamp(0, ballNumbers);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        endIndex - startIndex,
                        (index) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015, vertical: screenHeight * 0.008),
                              child: GenerateNumberBall(number: startIndex + index + 1),
                            ),
                          ); 
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ),
         
        ],
      )
    );
  }
}