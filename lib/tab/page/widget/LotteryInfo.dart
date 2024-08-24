import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottery_kr/tab/page/widget/SpecificInfoButton.dart';

class LotteryInfoCard extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  const LotteryInfoCard({super.key, required this.lotteryDetails});

  @override
  State<LotteryInfoCard> createState() => _LotteryInfoCardState();
}

class _LotteryInfoCardState extends State<LotteryInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_activity, color: Colors.teal[900], size: 30),
                SizedBox(width: 10),
                Expanded( // Wrapping Text with Expanded
                  child: Text(
                    widget.lotteryDetails["title"]!,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),
                    overflow: TextOverflow.ellipsis, // Handling overflow with ellipsis
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            _buildInfoRow(Icons.monetization_on, widget.lotteryDetails["highestPrize"]!),
            _buildInfoRow(Icons.schedule, widget.lotteryDetails["frequency"]!),
            _buildInfoRow(Icons.attach_money, widget.lotteryDetails["ticketPrice"]!),
            _buildInfoRow(Icons.calendar_today, widget.lotteryDetails["drawDate"]!),
            Row(
              children: [
                Icon(Icons.area_chart, color: Colors.black, size: 20),
                SizedBox(width: 10),
                Expanded( // Wrapping Text with Expanded
                  child: Text(
                    "purchasableArea".tr() + ": " + widget.lotteryDetails["purchasableArea"]!,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis, // Handling overflow with ellipsis
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SpecificButton(lotteryDetails: widget.lotteryDetails),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 20),
        SizedBox(width: 10),
        Expanded( // Wrapping Text with Expanded
          child: Text(
            text,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            overflow: TextOverflow.ellipsis, // Handling overflow with ellipsis
          ),
        ),
      ],
    );
  }
}
