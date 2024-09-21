import 'package:flutter/material.dart';
import 'package:lottery_kr/data/LotteryCardDetails.dart';
import 'package:lottery_kr/widget/LotteryCard.dart';

class LotteryList extends StatefulWidget {
  final String selectedTab;
  const LotteryList({super.key, required this.selectedTab});

  @override
  State<LotteryList> createState() => _LotteryListState();
}

class _LotteryListState extends State<LotteryList> {
  List<List<Map<String, dynamic>>> lotteryList = [];
  String currentTab = "";

  @override
  void initState() {
    super.initState();
    addLotteryDatasByCountry(widget.selectedTab);
    currentTab = widget.selectedTab;
  }

  @override
  void didUpdateWidget(covariant LotteryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTab != currentTab) {
      addLotteryDatasByCountry(widget.selectedTab);
      setState(() {
        currentTab = widget.selectedTab;
      });
    }
  }

  void addLotteryDatasByCountry(String country) {
    LotteryCardDetails lotteryCardDetails = LotteryCardDetails();
    setState(() {
      lotteryList = [];
      if (widget.selectedTab == "USA") {
        lotteryList.add(lotteryCardDetails.usLotteries);
      }
      else if (widget.selectedTab == "EU") {
        lotteryList.add(lotteryCardDetails.euLotteries);
      }
      else if (widget.selectedTab == "UK") {
        lotteryList.add(lotteryCardDetails.ukLotteries);
      }
      else if (widget.selectedTab == "Spain") {
        lotteryList.add(lotteryCardDetails.spainLotteries);
      }
      else if (widget.selectedTab == "Italy") {
        lotteryList.add(lotteryCardDetails.italyLotteries);
      }
      else if (widget.selectedTab == "Australia") {
        lotteryList.add(lotteryCardDetails.ausLotteries);
      }
      else if (widget.selectedTab == "Korea") {
        lotteryList.add(lotteryCardDetails.krLotteries);
      }
      else {
        lotteryList.add(lotteryCardDetails.japanLotteries);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: 
        Row( 
          children: List.generate(lotteryList[0].length, (index) {
            return LotteryCard(lotteryData: lotteryList[0][index]);
          })
        ) 
      ),
    );
  }
}