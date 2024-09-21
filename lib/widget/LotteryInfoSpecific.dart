import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LotteryInfoSpecific extends StatefulWidget {
  final Map<String, dynamic> lotteryDetails;
  const LotteryInfoSpecific({super.key, required this.lotteryDetails});

  @override
  State<LotteryInfoSpecific> createState() => _LotteryInfoSpecificState();
}

class _LotteryInfoSpecificState extends State<LotteryInfoSpecific> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) { 
    return Container(
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
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
            SizedBox(height: 30),
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
                      widget.lotteryDetails['title'],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity, // Ensure the container takes up the full width
              child: Column(
                children: [
                  _buildCard(
                    title: "purchasableArea".tr(),
                    content: Text(
                      widget.lotteryDetails['purchasableArea'],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16, 
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildCard(
                    title: "probability".tr(),
                    content: _buildListContent(widget.lotteryDetails['probabilities'], Icons.percent),
                  ),
                  SizedBox(height: 20),
                  _buildCard(
                    title: "prizeInfo".tr(),
                    content: _buildListContent(widget.lotteryDetails['prizeDetails'], Icons.monetization_on),
                  ),
                  SizedBox(height: 20),
                  _buildCard(
                    title: "method".tr(),
                    content: _buildListContent(widget.lotteryDetails['winningMethods'], Icons.check_circle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListContent(List<dynamic> items, IconData icon) {
    return Column(
      children: items.map<Widget>((item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                item,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildCard({required String title, required Widget content}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.green, size: 24),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
}
