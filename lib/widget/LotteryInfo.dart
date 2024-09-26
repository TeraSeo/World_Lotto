import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottery_kr/widget/buttons/HowToPlayButton.dart';

class LotteryInfoCard extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  const LotteryInfoCard({super.key, required this.lotteryDetails});

  @override
  State<LotteryInfoCard> createState() => _LotteryInfoCardState();
}

class _LotteryInfoCardState extends State<LotteryInfoCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: widget.lotteryDetails["color"], 
          center: Alignment.center, 
          radius: 1.2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.05)),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 1),
        ],
      ),
      padding: EdgeInsets.all(screenWidth * 0.05),
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_activity, color: Colors.white, size: screenHeight * 0.032),
              SizedBox(width: screenWidth * 0.023),
              Expanded(
                child: Text(
                  widget.lotteryDetails["title"]!,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: screenHeight * 0.026,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.013),
          _buildInfoRow(Icons.monetization_on, widget.lotteryDetails["highestPrize"]!, screenHeight * 0.023, screenWidth * 0.02, screenHeight * 0.018),
          _buildInfoRow(Icons.schedule, widget.lotteryDetails["frequency"]!, screenHeight * 0.023, screenWidth * 0.02, screenHeight * 0.018),
          _buildInfoRow(Icons.attach_money, widget.lotteryDetails["ticketPrice"]!, screenHeight * 0.023, screenWidth * 0.02, screenHeight * 0.018),
          _buildInfoRow(Icons.calendar_today, widget.lotteryDetails["drawDate"]!, screenHeight * 0.023, screenWidth * 0.02, screenHeight * 0.018),
          Row(
            children: [
              Icon(Icons.area_chart, color: Colors.white, size: screenHeight * 0.023),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  "purchasableArea".tr() + ": " + widget.lotteryDetails["purchasableArea"]!,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: screenHeight * 0.018,
                      color: Colors.white,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 130,
            child: HowToPlayButton(lotteryData: widget.lotteryDetails),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, double iconSize, double space, double textSize) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: iconSize),
        SizedBox(width: space),
        Expanded( // Wrapping Text with Expanded
          child: Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: textSize,
                color: Colors.white,
              ),
            ),
            overflow: TextOverflow.ellipsis, // Handling overflow with ellipsis
          ),
        ),
      ],
    );
  }
}
