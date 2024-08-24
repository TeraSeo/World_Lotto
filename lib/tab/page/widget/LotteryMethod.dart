import 'package:flutter/material.dart';

class LotteryMethodCard extends StatelessWidget {
  final String title;
  final List<String> methods;

  const LotteryMethodCard({
    super.key,
    required this.title,
    required this.methods,
  });

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
            Row(),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
            SizedBox(height: 8),
            ...methods.map((method) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                method,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
